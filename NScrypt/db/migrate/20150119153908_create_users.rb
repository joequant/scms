class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :legal_name
      t.string :email
      t.string :password_hash
      t.string :password_salt
      t.string :type

      t.timestamps null: false
    end
  end
end
