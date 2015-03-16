class CreateMinutes < ActiveRecord::Migration
  def change
    create_table :minutes do |t|
      t.string :message
      t.belongs_to :contract, index: true

      t.timestamps null: false
    end
    add_foreign_key :minutes, :contracts
  end
end
