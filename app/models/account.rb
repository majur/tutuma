class Account < ApplicationRecord
  has_many :users, dependent: :destroy
  has_many :invitations, dependent: :destroy
  validates :name, presence: true

  def admin
    users.find_by(admin: true)
  end
end
