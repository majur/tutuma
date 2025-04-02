class RegistrationsController < ApplicationController
    allow_unauthenticated_access

    def new
      @user = User.new
    end

    def create
      @account = Account.new(name: params[:team_name])
      @user = User.new(user_params)

      if @account.valid? && @user.valid?
        ActiveRecord::Base.transaction do
          @account.save!
          @user.save!
          @user.account_memberships.create!(account: @account, admin: true)
          
          # Vytvorenie predvoleného tímu pri registrácii a pridanie používateľa ako člena
          default_team = @account.create_default_team
          @user.team_memberships.create!(team: default_team)
        end
        start_new_session_for(@user)
        session[:current_account_id] = @account.id
        Current.account = @account
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
