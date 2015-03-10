class AddAssignStateToCode < ActiveRecord::Migration
  def change
    add_column :codes, :assign_state, :string
  end
end
