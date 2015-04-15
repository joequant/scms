class RenameUserToGrantor < ActiveRecord::Migration
  def change
    rename_column :rights, :user_id, :grantor_user_id
  end
end
