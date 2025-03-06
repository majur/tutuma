class InvitationsMailer < ApplicationMailer
  default from: "tutuma@tutuma.matase.sk"

  def invite(invitation)
    @invitation = invitation
    mail(
      to: invitation.email,
      subject: "Invitation to join #{invitation.account.name}"
    )
  end

  private

  def default_url_options
    Rails.application.config.action_mailer.default_url_options
  end
end
