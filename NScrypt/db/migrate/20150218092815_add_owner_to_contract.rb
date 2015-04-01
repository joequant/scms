class AddOwnerToContract < ActiveRecord::Migration
  def change
    add_foreign_key :contracts, :users, column: :owner
  end
end
