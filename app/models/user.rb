class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  belongs_to :account, optional: false

  normalizes :email_address, with: ->(e) { e.strip.downcase }
  validates :name, presence: true
  validates :admin, inclusion: { in: [true, false] }
end