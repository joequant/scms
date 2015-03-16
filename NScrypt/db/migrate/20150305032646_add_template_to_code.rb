class AddTemplateToCode < ActiveRecord::Migration
  def change
    add_column :codes, :template, :has_one
  end
end
