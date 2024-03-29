class Tag < ActiveRecord::Base
  attr_accessible :name

  has_many :taggings, :dependent => :destroy
  has_many :posts, :through => :taggings
end
