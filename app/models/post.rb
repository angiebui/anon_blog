class Post < ActiveRecord::Base
  validates :body, :presence => true
  validates :title, :presence => true

  has_many :tags, :through => :post_tags
  has_many :post_tags

  
end
