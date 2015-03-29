class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :status
      t.references :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :contacts, :users
  end
end
