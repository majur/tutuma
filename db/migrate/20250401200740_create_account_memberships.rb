class CreateAccountMemberships < ActiveRecord::Migration[8.0]
  def change
    create_table :account_memberships do |t|
      t.references :user, null: false, foreign_key: true
      t.references :account, null: false, foreign_key: true
      t.boolean :admin, default: false, null: false

      t.timestamps
    end

    add_index :account_memberships, [ :user_id, :account_id ], unique: true
  end
end
