class TeamMembership < ApplicationRecord
  belongs_to :user
  belongs_to :team
  
  validates :user_id, uniqueness: { scope: :team_id, message: "je už členom tohto tímu" }
end 