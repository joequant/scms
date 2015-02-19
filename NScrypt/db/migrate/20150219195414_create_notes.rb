class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.string :note
      t.belongs_to :contract, index: true
    end
    add_foreign_key :notes, :contracts
  end
end
