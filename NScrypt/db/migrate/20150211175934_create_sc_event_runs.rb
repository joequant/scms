class CreateScEventRuns < ActiveRecord::Migration
  def change
    create_table :sc_event_runs do |t|
      t.string :return_value
      t.datetime :run_at
      t.belongs_to :sc_event, index: true

      t.timestamps null: false
    end
    add_foreign_key :sc_event_runs, :sc_events
  end
end
