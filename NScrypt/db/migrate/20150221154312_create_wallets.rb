class CreateWallets < ActiveRecord::Migration
  def change
    create_table :wallets do |t|
      t.string :currency
      t.string :address
      t.belongs_to :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :wallets, :users
  end
end
