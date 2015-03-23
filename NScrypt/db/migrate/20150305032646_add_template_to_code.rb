class AddTemplateToCode < ActiveRecord::Migration
  def change
    add_foreign_key :codes, :templates
  end
end
