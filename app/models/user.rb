class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_many :account_memberships, dependent: :destroy
  has_many :accounts, through: :account_memberships
  
  normalizes :email_address, with: ->(e) { e.strip.downcase }
  validates :email_address, presence: true, uniqueness: true
  validates :name, presence: true

  # Pomocná metóda na zistenie, či je používateľ admin v konkrétnom tenante
  def admin_in?(account)
    account_memberships.find_by(account: account)&.admin? || false
  end

  # Vráti pre používateľa všetkých jeho adminov z rôznych tenantov
  def admins
    accounts.map(&:admin).uniq
  end

  def generate_password_reset_token
    signed_id expires_in: 2.hours, purpose: :password_reset
  end

  def self.find_by_password_reset_token!(token)
    find_signed(token, purpose: :password_reset)
  end
end
