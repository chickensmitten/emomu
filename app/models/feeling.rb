class Feeling < ActiveRecord::Base
  has_many :post_feelings
  has_many :posts, through: :post_feelings

  validates :name, presence: true

end