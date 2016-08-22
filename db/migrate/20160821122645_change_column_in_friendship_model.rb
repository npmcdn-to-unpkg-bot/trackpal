class ChangeColumnInFriendshipModel < ActiveRecord::Migration
  def change
    remove_column :friendships, :friend_id
  end
end
