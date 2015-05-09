class AddArchivedToCodes < ActiveRecord::Migration
  def change
    add_column :codes, :archived, :boolean
  end
end
