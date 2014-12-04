class Post < ActiveRecord::Base

  include PublicActivity::Common
  default_scope -> { order(created_at: :desc) }

  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'

  has_many :post_feelings
  has_many :feelings, through: :post_feelings

  validates :description, presence: true
  validates :url, presence: true, uniqueness: true

  self.per_page = 10


  def self.search(search)
    return [] if search.blank?
    where("description LIKE ?", "%#{search}%")
  end

end
