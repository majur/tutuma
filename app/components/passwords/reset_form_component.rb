# frozen_string_literal: true

class Passwords::ResetFormComponent < ViewComponent::Base
  def initialize(flash:, email_address: nil)
    @flash = flash
    @email_address = email_address
  end

  def self.stimulus_controller?
    true
  end
end 