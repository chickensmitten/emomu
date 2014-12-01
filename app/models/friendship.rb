class Friendship < ActiveRecord::Base

  include PublicActivity::Common

  belongs_to :follower, class_name: 'User', foreign_key: 'follower_id'
  belongs_to :leader, class_name: 'User', foreign_key: 'leader_id'

end