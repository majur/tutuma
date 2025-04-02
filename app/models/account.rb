class Account < ApplicationRecord
  has_many :account_memberships, dependent: :destroy
  has_many :users, through: :account_memberships
  has_many :invitations, dependent: :destroy
  has_many :teams, dependent: :destroy
  validates :name, presence: true

  def admin
    account_memberships.find_by(admin: true)&.user
  end

  def admins
    users.joins(:account_memberships).where(account_memberships: { account_id: id, admin: true })
  end
  
  # Vytvorí predvolený tím pre účet
  def create_default_team
    teams.create!(name: "#{name} HQ", description: "Hlavný tím pre #{name}")
  end
end
