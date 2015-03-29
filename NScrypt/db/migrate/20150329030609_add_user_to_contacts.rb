class AddUserToContacts < ActiveRecord::Migration
  def change
    add_reference :contacts, :user, index: true
    add_foreign_key :contacts, :users
  end
end
