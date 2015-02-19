class AddSignedCodeToContract < ActiveRecord::Migration
  def change
    add_column :contracts, :signed_code, :has_one
  end
end
