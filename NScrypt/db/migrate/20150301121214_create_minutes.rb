class CreateMinutes < ActiveRecord::Migration
  def change
    create_table :minutes do |t|
      t.belongs_to :contract, index: true
      t.belongs_to :user, index: true
      t.string :message
      t.datetime :when

      t.timestamps null: false
    end
    add_foreign_key :minutes, :contracts
    add_foreign_key :minutes, :users
  end
end
