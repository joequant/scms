class AddStateToCode < ActiveRecord::Migration
  def change
    add_column :codes, :state, :string
  end
end
