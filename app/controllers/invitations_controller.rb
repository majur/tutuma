class InvitationsController < ApplicationController
  allow_unauthenticated_access only: [:edit, :update]
  before_action :ensure_admin, only: [:new, :create]

  def new
    @invitation = Invitation.new
  end

  def create
    invitations_params = params[:invitations] || []
    created_invitations = []

    begin
      ActiveRecord::Base.transaction do
        invitations_params.each do |invitation_param|
          email = invitation_param[:email].strip
          name = invitation_param[:name].strip

          next if email.blank? || name.blank?
          next if User.exists?(email_address: email)

          invitation = current_user.account.invitations.create!(
            email: email.downcase,
            name: name,
            inviter: current_user,
          )
          created_invitations << invitation
        end
      end

      created_invitations.each do |invitation|
        InvitationsMailer.invite(invitation).deliver_later
      end

      redirect_to users_path, notice: "Invitations sent successfully."
    rescue ActiveRecord::RecordInvalid => e
      redirect_to new_invitation_path, alert: "Error: #{e.message}"
    end
  end

  def edit
    @invitation = Invitation.find_by!(token: params[:token])
    handle_expired_or_accepted && return
    @user = User.new(email_address: @invitation.email, name: @invitation.name)
  end
    
      def update
        @invitation = Invitation.find_by!(token: params[:token])
        handle_expired_or_accepted && return
    
        @user = User.new(user_params.merge(account: @invitation.account, admin: false))
    
        if @user.save
          @invitation.update!(accepted: true)
          start_new_session_for(@user)
          redirect_to root_path, notice: "Account activated!"
        else
          render :edit, status: :unprocessable_entity
        end
      end
  
    private

    def handle_expired_or_accepted
      if @invitation.expired? || @invitation.accepted == true
        redirect_to new_session_path, alert: "Invitation invalid/expired."
        return true
      end
    end

    def user_params
      params.require(:user).permit(:name, :email_address, :password, :password_confirmation)
    end
  
    def ensure_admin
      redirect_to root_path, alert: "Not authorized" unless current_user.admin?
    end
  end