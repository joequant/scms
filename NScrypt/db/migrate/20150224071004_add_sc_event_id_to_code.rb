class AddScEventIdToCode < ActiveRecord::Migration
  def change
    add_column :codes, :sc_event_id, :integer
    add_foreign_key :codes, :sc_events
  end
end
