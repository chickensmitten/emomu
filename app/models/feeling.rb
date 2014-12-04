class Feeling < ActiveRecord::Base
  include PublicActivity::Common
    
  has_many :post_feelings
  has_many :posts, through: :post_feelings

  has_many :user_feelings, dependent: :destroy
  has_many :users, through: :user_feelings  

  validates :name, presence: true

end