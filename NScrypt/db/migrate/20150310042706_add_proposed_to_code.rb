class AddProposedToCode < ActiveRecord::Migration
  def change
    add_column :codes, :proposed, :boolean
  end
end
