class CreateReputations < ActiveRecord::Migration
  def change
    create_table :reputations do |t|
      t.belongs_to :user, index: true
      t.belongs_to :contract, index: true
      t.string :category
      t.string :subcategory
      t.string :item
      t.string :params
      t.string :status

      t.timestamps null: false
    end
    add_foreign_key :reputations, :users
    add_foreign_key :reputations, :contracts
  end
end
