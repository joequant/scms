class AddSignStateToCode < ActiveRecord::Migration
  def change
    add_column :codes, :sign_state, :string
  end
end
