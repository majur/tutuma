class RegistrationsController < ApplicationController
    allow_unauthenticated_access

    def new
      @user = User.new
    end

    def create
      ActiveRecord::Base.transaction do
        @account = Account.create!(name: params[:team_name])
        @user = @account.users.create!(user_params.merge(admin: true))

        start_new_session_for(@user)
        redirect_to root_path, notice: "Team registration successful!"
      rescue ActiveRecord::RecordInvalid => e
        Rails.logger.error "Registration failed: #{e.message}"
        @user ||= User.new
        render :new, status: :unprocessable_entity
      end
    end

    private

    def user_params
      params.require(:user).permit(:name, :email_address, :password, :password_confirmation)
    end
end
