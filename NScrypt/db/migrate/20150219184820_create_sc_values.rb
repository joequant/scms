class CreateScValues < ActiveRecord::Migration
  def change
    create_table :sc_values do |t|
      t.belongs_to :contract, index: true
      t.string :key
      t.string :value
    end
    add_foreign_key :sc_values, :contracts
  end
end
