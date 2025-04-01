class RemoveAccountAndAdminFromUsers < ActiveRecord::Migration[8.0]
  def change
    remove_reference :users, :account, foreign_key: true
    remove_column :users, :admin, :boolean
  end
end
