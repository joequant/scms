class AddScEventIdToContract < ActiveRecord::Migration
  def change
    add_column :contracts, :sc_event_id, :integer
    add_foreign_key :contracts, :sc_events
  end
end
