class CreateInvitations < ActiveRecord::Migration[8.0]
  def change
    create_table :invitations do |t|
      t.string :email
      t.string :token
      t.datetime :expires_at
      t.boolean :accepted
      t.references :account, null: false, foreign_key: true
      t.references :inviter, null: false, foreign_key: true

      t.timestamps
    end
    add_index :invitations, :token
  end
end
