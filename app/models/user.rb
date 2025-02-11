class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  belongs_to :account, optional: false

  normalizes :email_address, with: ->(e) { e.strip.downcase }
  validates :name, presence: true
  validates :admin, inclusion: { in: [true, false] }

  def generate_password_reset_token
    signed_id expires_in: 2.hours, purpose: :password_reset
  end

  def self.find_by_password_reset_token!(token)
    find_signed(token, purpose: :password_reset)
  end
end