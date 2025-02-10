class FixInviterForeignKeyInInvitations < ActiveRecord::Migration[8.0]
  def change
    # Remove the incorrect foreign key
    remove_foreign_key :invitations, column: :inviter_id

    # Add the correct foreign key to the users table
    add_foreign_key :invitations, :users, column: :inviter_id
  end
end