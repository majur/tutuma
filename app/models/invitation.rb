class Invitation < ApplicationRecord
  belongs_to :account
  belongs_to :inviter, class_name: "User"

  before_create :generate_token
  validates :email, presence: true, format: URI::MailTo::EMAIL_REGEXP
  validates :name, presence: true

  def expired?
    expires_at < Time.current
  end

  private

  def generate_token
    self.token = SecureRandom.hex(20)
    self.expires_at ||= 1.week.from_now
  end
end
