class Tagging < ActiveRecord::Base
  attr_accessible :post_id, :tag_id

  belongs_to :tag, :counter_cache => true, touch: true
  belongs_to :post
end
