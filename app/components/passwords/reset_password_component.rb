# frozen_string_literal: true

module Passwords
  class ResetPasswordComponent < ViewComponent::Base
    attr_reader :email_address

    def initialize(email_address: nil, flash: {})
      @email_address = email_address
      @flash = flash
    end

    private

    def flash_alert
      @flash[:alert]
    end
  end
end
