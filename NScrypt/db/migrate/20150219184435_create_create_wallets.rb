class CreateCreateWallets < ActiveRecord::Migration
  def change
    create_table :create_wallets do |t|
      t.string :currency
      t.string :address
      t.belongs_to :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :create_wallets, :users
  end
end
