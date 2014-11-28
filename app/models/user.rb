class User < ActiveRecord::Base

  has_many :posts
  has_many :emotions

  has_many :follower_friendships, class_name: "Friendship", foreign_key: "leader_id"
  has_many :followers, through: :follower_friendships, source: :follower

  has_many :leader_friendships, class_name: "Friendship", foreign_key: "follower_id"
  has_many :followings, through: :leader_friendships, source: :leader 

  has_secure_password validations: false

  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, on: :create, length: {minimum: 5}

  def admin?
    self.role == 'admin'
  end

  def moderator?
    self.role == 'moderator?'
  end

end
