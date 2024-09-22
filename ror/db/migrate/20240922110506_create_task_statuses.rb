class CreateTaskStatuses < ActiveRecord::Migration[7.1]
  def up
    execute <<-SQL
      CREATE TYPE task_status_state AS ENUM ('inactive', 'active', 'archived');
    SQL

    create_table :task_statuses do |t|
      t.references :board, null: false, foreign_key: true
      t.string :name
      t.integer :position
      t.string :state

      t.timestamps
    end
  end

  def down
    drop_table :task_statuses

    execute <<-SQL
      DROP TYPE task_status_state;
    SQL
  end
end
