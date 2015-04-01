class CreateScEvents < ActiveRecord::Migration
  def change
    create_table :sc_events do |t|
      t.text :callback
      t.references :code, index: true, null: false

      t.timestamps null: false
    end
    add_foreign_key :sc_events, :codes
  end
end
