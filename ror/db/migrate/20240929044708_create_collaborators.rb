class CreateCollaborators < ActiveRecord::Migration[7.1]
  def up
    execute <<-SQL
      CREATE TYPE collaboration_status AS ENUM ('open', 'accepted', 'declined');
    SQL

    create_table :collaborators do |t|
      t.references :collaborateable, polymorphic: true, null: false
      t.references :user, null: false, foreign_key: true
      t.references :inviter, null: false, foreign_key: { to_table: :users }
      t.string :invitation_email

      t.timestamps
    end
  end

  def down
    drop_table :collaborators

    execute <<-SQL
      DROP TYPE collaboration_status;
    SQL
  end
end
