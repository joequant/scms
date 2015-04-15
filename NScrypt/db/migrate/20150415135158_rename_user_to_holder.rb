class RenameUserToHolder < ActiveRecord::Migration
  def change
    rename_column :rights, :user_id, :holder_user_id
  end
end
