class CreateContracts < ActiveRecord::Migration
  def change
    create_table :contracts do |t|
      t.string :title
      t.string :description
      t.references :code, index: true

      t.timestamps null: false
    end
    add_foreign_key :contracts, :code
  end
end
