class AddSignedCodeIdToContracts < ActiveRecord::Migration
  def change
    add_column :contracts, :signed_code_id, :has_one
  end
end
