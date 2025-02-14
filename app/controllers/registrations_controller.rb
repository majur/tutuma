class RegistrationsController < ApplicationController
    allow_unauthenticated_access

    def new
      @user = User.new
    end

    def create
      @account = Account.new(name: params[:team_name])
      @user = @account.users.build(user_params.merge(admin: true))

      if @account.valid? && @user.valid?
        ActiveRecord::Base.transaction do
          @account.save!
          @user.save!
        end
        start_new_session_for(@user)
        redirect_to root_path, notice: "Team registration successful!"
      else
        render :new, status: :unprocessable_entity
      end
    rescue ActiveRecord::RecordInvalid => e
      Rails.logger.error "Registration failed: #{e.message}"
      render :new, status: :unprocessable_entity
    end

    private

    def user_params
      params.require(:user).permit(:name, :email_address, :password, :password_confirmation)
    end
end
