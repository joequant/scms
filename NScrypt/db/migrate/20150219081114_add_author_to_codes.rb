class AddAuthorToCodes < ActiveRecord::Migration
  def change
    add_column :codes, :author, :user
  end
end
