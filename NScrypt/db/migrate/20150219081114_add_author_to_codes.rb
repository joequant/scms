class AddAuthorToCodes < ActiveRecord::Migration
  def change
    add_column :codes, :author, :integer
    add_foreign_key :codes, :users, column: :author
  end
end
