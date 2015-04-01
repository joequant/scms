class AddTemplateToCode < ActiveRecord::Migration
  def change
    add_column :codes, :template_id, :integer
    add_foreign_key :codes, :templates
  end
end
