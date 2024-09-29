class CreateTasks < ActiveRecord::Migration[7.1]
  def change

    create_table :tasks do |t|
      t.string :title
      t.references :board, null: false, foreign_key: true
      t.references :task_status, null: false, foreign_key: true
      t.references :creator, null: false, foreign_key: { to_table: :users }
      t.references :assignee, null: true, foreign_key: { to_table: :users }
      t.integer :position

      t.timestamps
    end
  end
end
