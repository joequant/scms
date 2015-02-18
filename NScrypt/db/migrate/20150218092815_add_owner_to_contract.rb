class AddOwnerToContract < ActiveRecord::Migration
  def change
    add_column :contracts, :owner, :has_one
  end
end
