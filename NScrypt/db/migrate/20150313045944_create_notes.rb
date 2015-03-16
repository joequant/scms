class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.string :message
      t.belongs_to :contract, index: true
      t.belongs_to :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :notes, :contracts
    add_foreign_key :notes, :users
  end
end
