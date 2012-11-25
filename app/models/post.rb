class Post < ActiveRecord::Base
  attr_accessible :body, :title, :tag_names

  has_many :taggings, :dependent => :destroy
  has_many :tags, :through => :taggings

  def tag_names
    self.tags.all.map(&:name).join(',')
  end

  def tag_names=(tag_list)
    tag_names = tag_list.gsub(/\s+/, "").split(",")
    existing = self.tags.map {|t| t.name }
    (existing - tag_names).each do |name|
      self.tags.delete Tag.find_by_name(name)
    end
    tag_names.each do |name|
      self.tags << Tag.find_or_create_by_name(name)
    end
  end
end
