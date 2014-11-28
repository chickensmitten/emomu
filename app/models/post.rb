class Post < ActiveRecord::Base

  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'

  has_many :post_feelings
  has_many :feelings, through: :post_feelings

  validates :description, presence: true
  validates :url, presence: true, uniqueness: true


end
