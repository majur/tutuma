class Current < ActiveSupport::CurrentAttributes
  attribute :session
  attribute :account
  delegate :user, to: :session, allow_nil: true
  
  # Resets current account
  def self.reset_account
    self.account = nil
  end
end
