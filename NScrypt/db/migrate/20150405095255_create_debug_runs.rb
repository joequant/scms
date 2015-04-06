class CreateDebugRuns < ActiveRecord::Migration
  def change
    create_table :debug_runs do |t|
      t.string :input
      t.string :output
      t.string :pre_state
      t.string :post_state
      t.belongs_to :code, index: true
      t.belongs_to :user, index: true
      t.boolean :has_error

      t.timestamps null: false
    end
    add_foreign_key :debug_runs, :codes
    add_foreign_key :debug_runs, :users
  end
end
