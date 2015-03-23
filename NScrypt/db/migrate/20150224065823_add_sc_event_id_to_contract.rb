class AddScEventIdToContract < ActiveRecord::Migration
  def change
    add_foreign_key :contracts, :sc_events
  end
end
