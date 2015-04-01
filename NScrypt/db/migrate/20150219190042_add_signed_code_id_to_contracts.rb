class AddSignedCodeIdToContracts < ActiveRecord::Migration
  def change
    add_column :contracts, :signed_code_id, :integer
    add_foreign_key :contracts, :codes, column: :signed_code_id
  end
end
