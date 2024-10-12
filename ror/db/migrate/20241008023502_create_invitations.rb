class CreateInvitations < ActiveRecord::Migration[7.1]
  def up
    execute <<-SQL
      CREATE TYPE invitation_status AS ENUM ('invited', 'accepted', 'declined');
    SQL

    create_table :invitations do |t|
      t.references :collaborateable, polymorphic: true, null: false
      t.string :email, null: false
      t.references :invitee, null: true, foreign_key: { to_table: :users }
      t.references :inviter, null: false, foreign_key: { to_table: :users }
      t.references :collaborator, null: true

      t.timestamps
    end

    add_column :invitations, :status, :invitation_status
  end

  def down
    drop_table :invitations

    execute <<-SQL
      DROP TYPE invitation_status;
    SQL
  end
end
