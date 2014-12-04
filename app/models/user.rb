class User < ActiveRecord::Base

  include PublicActivity::Common
  default_scope -> { order(created_at: :desc) }

  has_many :posts, dependent: :destroy
  
  has_many :user_feelings, dependent: :destroy
  has_many :feelings, through: :user_feelings

  has_many :follower_friendships, class_name: "Friendship", foreign_key: "leader_id", dependent: :destroy
  has_many :followers, through: :follower_friendships, source: :follower

  has_many :leader_friendships, class_name: "Friendship", foreign_key: "follower_id", dependent: :destroy
  has_many :followings, through: :leader_friendships, source: :leader 
  #following_ids method is synthesized from "followings" above by Active Record based on the has_many :following association; 
  #the result is that we need only append _ids to the association name to get the ids corresponding to the user.following collection

  has_secure_password validations: false

  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, on: :create, length: {minimum: 5}
  before_create { generate_token(:auth_token) }

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

  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    UserMailer.password_reset(self).deliver
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end

end
