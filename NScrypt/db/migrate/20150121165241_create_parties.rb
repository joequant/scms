class CreateParties < ActiveRecord::Migration
  def change
    create_table :parties do |t|
      t.references :person, index: true
      t.references :code, index: true
      t.references :role, index: true
      t.string :state

      t.timestamps null: false
    end
    add_foreign_key :parties, :people
    add_foreign_key :parties, :codes
    add_foreign_key :parties, :roles
  end
end
