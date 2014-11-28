class PostFeeling < ActiveRecord::Base
  belongs_to :post
  belongs_to :feeling
end