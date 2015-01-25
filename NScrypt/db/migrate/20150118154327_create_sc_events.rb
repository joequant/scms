class CreateScEvents < ActiveRecord::Migration
  def change
    create_table :sc_events do |t|
      t.text :callback
      t.references :contract, index: true

      t.timestamps null: false
    end
    add_foreign_key :sc_events, :contract
  end
end
