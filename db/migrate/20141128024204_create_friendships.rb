class CreateFriendships < ActiveRecord::Migration
  def change
    create_table :friendships do |t|
      t.integer :follower_id, :leader_id
      t.timestamps
    end
  end
end
