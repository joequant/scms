class CreateCodes < ActiveRecord::Migration
  def change
    create_table :codes do |t|
      t.string :version
      t.text :code

      t.timestamps null: false
    end
  end
end
