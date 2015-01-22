class CreateParties < ActiveRecord::Migration
  def change
    create_table :parties do |t|
      t.references :person, index: true
      t.references :contract, index: true
      t.references :role, index: true

      t.timestamps null: false
    end
    add_foreign_key :parties, :people
    add_foreign_key :parties, :contracts
    add_foreign_key :parties, :roles
  end
end
