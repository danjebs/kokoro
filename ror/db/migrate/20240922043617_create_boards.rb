class CreateBoards < ActiveRecord::Migration[7.1]
  def up
    execute <<-SQL
      CREATE TYPE board_status AS ENUM ('active', 'archived');
    SQL

    create_table :boards do |t|

      t.string :name
      t.integer :position
      t.references :creator, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end

    add_column :boards, :status, :board_status
  end

  def down
    drop_table :boards

    execute <<-SQL
      DROP TYPE board_status;
    SQL
  end
end
