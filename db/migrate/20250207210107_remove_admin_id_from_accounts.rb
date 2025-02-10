class RemoveAdminIdFromAccounts < ActiveRecord::Migration[8.0]
  def change
    remove_column :accounts, :admin_id
  end
end
