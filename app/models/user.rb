class User < ActiveRecord::Base

  include PublicActivity::Common
  default_scope -> { order(created_at: :desc) }

  has_many :posts, dependent: :destroy
  has_many :feelings, dependent: :destroy

  has_many :follower_friendships, class_name: "Friendship", foreign_key: "leader_id", dependent: :destroy
  has_many :followers, through: :follower_friendships, source: :follower

  has_many :leader_friendships, class_name: "Friendship", foreign_key: "follower_id", dependent: :destroy
  has_many :followings, through: :leader_friendships, source: :leader 
  #following_ids method is synthesized from "followings" above by Active Record based on the has_many :following association; 
  #the result is that we need only append _ids to the association name to get the ids corresponding to the user.following collection

  has_secure_password validations: false

  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, on: :create, length: {minimum: 5}

  def admin?
    self.role == 'admin'
  end

  def moderator?
    self.role == 'moderator?'
  end

  def feed
    following_ids = "SELECT leader_id FROM friendships
                     WHERE  follower_id = :user_id"
    Post.where("user_id IN (#{following_ids})
                     OR user_id = :user_id", user_id: id) # Produces feeds for timeline
  end

end
