class AddRoleToParty < ActiveRecord::Migration
  def change
    add_column :parties, :role, :string
  end
end
