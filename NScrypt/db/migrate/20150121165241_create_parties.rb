class CreateParties < ActiveRecord::Migration
  def change
    create_table :parties do |t|
      t.references :user, index: true
      t.references :code, index: true
      t.references :role, index: true
      t.string :state

      t.timestamps null: false
    end
    add_foreign_key :parties, :users
    add_foreign_key :parties, :codes
    add_foreign_key :parties, :roles
  end
end
