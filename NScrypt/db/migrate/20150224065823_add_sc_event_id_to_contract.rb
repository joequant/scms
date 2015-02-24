class AddScEventIdToContract < ActiveRecord::Migration
  def change
    add_column :contracts, :sc_event_id, :has_one
  end
end
