class ChengeColumnNullTasks < ActiveRecord::Migration[5.2]
  change_column :tasks, :name, :string, null: false
  change_column :tasks, :detail, :text, null: false
end
