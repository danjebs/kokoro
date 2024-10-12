class CreateCollaborators < ActiveRecord::Migration[7.1]
  def change
    create_table :collaborators do |t|
      t.references :collaborateable, polymorphic: true, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
