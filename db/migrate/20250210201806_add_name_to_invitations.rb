class AddNameToInvitations < ActiveRecord::Migration[8.0]
  def change
    add_column :invitations, :name, :string
  end
end
