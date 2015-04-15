class CreateRights < ActiveRecord::Migration
  def change
    create_table :rights do |t|
      t.belongs_to :user, index: true
      t.belongs_to :contract, index: true
      t.string :name
      t.boolean :subsists

      t.timestamps null: false
    end
    add_foreign_key :rights, :users
    add_foreign_key :rights, :contracts
  end
end
