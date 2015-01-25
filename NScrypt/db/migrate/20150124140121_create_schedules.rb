class CreateSchedules < ActiveRecord::Migration
  def change

    create_table :schedules do |t|
      t.references :sc_event, index: true, null: false
      t.datetime :timestamp
      t.string :argument
      t.boolean :recurrent
      t.string :status

      t.timestamps null: false
    end
    add_foreign_key :schedules, :sc_event
  end
end
