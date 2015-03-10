class AddRejectedToCode < ActiveRecord::Migration
  def change
    add_column :codes, :rejected, :boolean
  end
end
