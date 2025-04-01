class InvitationsController < ApplicationController
  allow_unauthenticated_access only: [ :edit, :update ]
  before_action :ensure_admin, only: [ :new, :create ]

  def new
    render Invitations::InvitationFormComponent.new(flash: flash)
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
          if User.joins(:account_memberships).where(email_address: email, account_memberships: { account_id: current_account.id }).exists?
            next
          end

          invitation = current_account.invitations.create!(
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

      redirect_to users_path, notice: "Pozvánky boli úspešne odoslané."
    rescue ActiveRecord::RecordInvalid => e
      redirect_to new_invitation_path, alert: "Chyba: #{e.message}"
    end
  end

  def edit
    @invitation = Invitation.find_by!(token: params[:token])
    handle_expired_or_accepted && return
    
    @existing_user = User.find_by(email_address: @invitation.email)
    
    if @existing_user
      render :existing_user
    else
      @user = User.new(email_address: @invitation.email, name: @invitation.name)
      render :edit
    end
  end

  def update
    @invitation = Invitation.find_by!(token: params[:token])
    handle_expired_or_accepted && return

    @existing_user = User.find_by(email_address: @invitation.email)
    
    if @existing_user
      if @existing_user.accounts.include?(@invitation.account)
        redirect_to new_session_path, alert: "Už ste členom tohto tímu."
        return
      end
      
      @existing_user.account_memberships.create!(account: @invitation.account, admin: false)
      @invitation.update!(accepted: true)
      
      start_new_session_for(@existing_user)
      session[:current_account_id] = @invitation.account_id
      Current.account = @invitation.account
      
      redirect_to root_path, notice: "Boli ste pridaný do tímu #{@invitation.account.name}!"
    else
      @user = User.new(user_params)
      
      if @user.save
        @user.account_memberships.create!(account: @invitation.account, admin: false)
        @invitation.update!(accepted: true)
        
        start_new_session_for(@user)
        session[:current_account_id] = @invitation.account_id
        Current.account = @invitation.account
        
        redirect_to root_path, notice: "Váš účet bol aktivovaný!"
      else
        render :edit, status: :unprocessable_entity
      end
    end
  end

  private

  def handle_expired_or_accepted
    if @invitation.expired? || @invitation.accepted == true
      redirect_to new_session_path, alert: "Pozvánka je neplatná alebo už bola použitá."
      true
    end
  end

  def user_params
    params.require(:user).permit(:name, :email_address, :password, :password_confirmation)
  end

  def ensure_admin
    redirect_to root_path, alert: "Nemáte oprávnenie na túto akciu" unless current_user.admin_in?(current_account)
  end
end
