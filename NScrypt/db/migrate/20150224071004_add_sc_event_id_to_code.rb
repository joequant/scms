class AddScEventIdToCode < ActiveRecord::Migration
  def change
    add_foreign_key :codes, :sc_events
  end
end
