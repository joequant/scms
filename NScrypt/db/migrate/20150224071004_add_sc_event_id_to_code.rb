class AddScEventIdToCode < ActiveRecord::Migration
  def change
    add_column :codes, :sc_event_id, :has_one
  end
end
