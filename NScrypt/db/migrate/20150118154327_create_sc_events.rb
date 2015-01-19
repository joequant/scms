class CreateScEvents < ActiveRecord::Migration
  def change
    create_table :sc_events do |t|

      t.timestamps null: false
    end
  end
end
