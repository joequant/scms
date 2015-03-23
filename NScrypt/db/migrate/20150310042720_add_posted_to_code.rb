class AddPostedToCode < ActiveRecord::Migration
  def change
    add_column :codes, :posted, :boolean
  end
end
