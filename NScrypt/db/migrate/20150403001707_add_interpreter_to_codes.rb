class AddInterpreterToCodes < ActiveRecord::Migration
  def change
    add_column :codes, :interpreter, :string
  end
end
