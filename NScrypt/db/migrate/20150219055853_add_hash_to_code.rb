class AddHashToCode < ActiveRecord::Migration
  def change
    add_column :codes, :hash, :string
  end
end
