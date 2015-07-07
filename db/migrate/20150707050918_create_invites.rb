class CreateInvites < ActiveRecord::Migration
  def change
    create_table :invites do |t|
      t.integer :user_id
      t.integer :invite_id

      t.timestamps null: false
    end
    add_index :invites, :user_id
    add_index :invites, :invite_id
  end
end
