# frozen_string_literal: true

module Sessions
  class LoginFormComponent < ViewComponent::Base
    attr_reader :email_address

    def initialize(email_address: nil, flash: {})
      @email_address = email_address
      @flash = flash
    end

    private

    def flash_alert
      @flash[:alert]
    end

    def flash_notice
      @flash[:notice]
    end
  end
end
