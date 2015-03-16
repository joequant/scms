class RemoveRoleFromParty < ActiveRecord::Migration
  def change
    remove_column :parties, :role_id, :integer
  end
end
