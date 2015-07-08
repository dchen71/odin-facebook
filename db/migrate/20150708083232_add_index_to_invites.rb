class AddIndexToInvites < ActiveRecord::Migration
  def change
	add_index :invites, [:invite_id, :user_id], unique: true
  end
end
