class CreateContracts < ActiveRecord::Migration
  def change
    create_table :contracts do |t|
      t.string :title
      t.string :description
      t.references :codes, index: true

      t.timestamps null: false
    end
  end
end
