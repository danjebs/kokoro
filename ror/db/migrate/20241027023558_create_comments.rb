class CreateComments < ActiveRecord::Migration[7.1]
  def change
    create_table :comments do |t|
      t.references :commentable, polymorphic: true, null: false
      t.references :user, null: false, foreign_key: true
      t.string :content, null: false

      t.timestamps
    end
  end
end
