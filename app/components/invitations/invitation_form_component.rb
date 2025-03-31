module Invitations
  class InvitationFormComponent < ViewComponent::Base
    def initialize(flash: {})
      @flash = flash
      @invitation = Invitation.new
    end

    private

    attr_reader :invitation

    def flash_alert
      @flash[:alert]
    end

    def flash_notice
      @flash[:notice]
    end
  end
end 