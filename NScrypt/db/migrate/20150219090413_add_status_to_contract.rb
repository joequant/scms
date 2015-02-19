class AddStatusToContract < ActiveRecord::Migration
  def change
    add_column :contracts, :status, :string
  end
end
