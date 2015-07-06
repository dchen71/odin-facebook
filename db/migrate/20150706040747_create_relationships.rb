class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      t.integer :friend_id
      t.integer :invite_id

      t.timestamps null: false
    end
    add_index :relationships, :friend_id
    add_index :relationships, :invite_id
    add_index :relationships, [:invite_id, :friend_id], unique: true
  end
end
