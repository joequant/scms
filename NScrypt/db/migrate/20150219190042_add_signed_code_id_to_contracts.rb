class AddSignedCodeIdToContracts < ActiveRecord::Migration
  def change
    add_foreign_key :contracts, :codes, column: :signed_code_id
  end
end
