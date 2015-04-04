class AddInterpreterVersionToCodes < ActiveRecord::Migration
  def change
    add_column :codes, :interpreter_version, :string
  end
end
