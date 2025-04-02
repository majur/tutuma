class MigrateUserAccountsToMemberships < ActiveRecord::Migration[8.0]
  def up
    # Presunúť existujúce vzťahy do novej join tabuľky
    execute <<-SQL
      INSERT INTO account_memberships (user_id, account_id, admin, created_at, updated_at)
      SELECT id, account_id, admin, datetime('now'), datetime('now') FROM users
    SQL
  end

  def down
    # V prípade rollbacku zmažeme záznamy, ktoré sme vytvorili
    execute "DELETE FROM account_memberships"
  end
end
