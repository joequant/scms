class CreateTemplates < ActiveRecord::Migration
  def change
    create_table :templates do |t|
      t.string :name
      t.string :description
      t.belongs_to :user, index: true
      t.string :code

      t.timestamps null: false
    end
    add_foreign_key :templates, :users
  end
end
