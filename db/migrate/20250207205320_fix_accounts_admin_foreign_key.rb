class FixAccountsAdminForeignKey < ActiveRecord::Migration[8.0]
  def change
    remove_foreign_key :accounts, column: :admin_id
    add_foreign_key :accounts, :users, column: :admin_id
  end
end
