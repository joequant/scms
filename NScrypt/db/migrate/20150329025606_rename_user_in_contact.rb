class RenameUserInContact < ActiveRecord::Migration
  def change
    rename_column :contacts, :user_id, :contact_user_id
  end
end
