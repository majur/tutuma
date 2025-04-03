class AddDefaultTeamsToExistingAccounts < ActiveRecord::Migration[8.0]
  def up
    # Zabezpečíme, že modely reflektujú aktuálnu schému
    load Rails.root.join('app/models/application_record.rb')
    load Rails.root.join('app/models/account.rb')
    load Rails.root.join('app/models/user.rb')
    load Rails.root.join('app/models/team.rb')
    load Rails.root.join('app/models/team_membership.rb')
    load Rails.root.join('app/models/account_membership.rb')

    # Pre každý existujúci účet vytvoríme predvolený tím
    Account.find_each do |account|
      puts "Vytváram predvolený tím pre účet: #{account.name}"
      
      # Vytvoríme predvolený tím
      default_team = account.teams.create!(
        name: "#{account.name} HQ",
        description: "Hlavný tím pre #{account.name}"
      )
      
      # Pridáme všetkých používateľov účtu do predvoleného tímu
      account.users.find_each do |user|
        puts "  - Pridávam používateľa #{user.name} do tímu #{default_team.name}"
        begin
          # Vytvoríme členstvo v tíme
          user.team_memberships.create!(team: default_team)
        rescue ActiveRecord::RecordInvalid => e
          puts "    - Chyba pri pridávaní: #{e.message}"
        end
      end
    end
  end

  def down
    # Táto migrácia sa nedá vrátiť späť bez straty dát, preto necháme down prázdny
  end
end
