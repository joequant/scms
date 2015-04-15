class AddUserToRights < ActiveRecord::Migration
  def change
    add_reference :rights, :user, index: true
    add_foreign_key :rights, :users
  end
end
