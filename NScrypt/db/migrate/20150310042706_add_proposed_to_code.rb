class AddProposedToCode < ActiveRecord::Migration
  def change
    add_column :codes, :proposed, :bool
  end
end
