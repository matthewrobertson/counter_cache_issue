require 'test_helper'

class PostTest < ActiveSupport::TestCase

  def setup
    @post = Post.create(:title => "On Kittens", :body => "They are fun to pet")
    @post.tag_names = 'cats'
  end

  test 'counter cache is incremented properly' do
    assert Tag.find_by_name('cats').taggings_count == 1
  end

  test 'counter cache is decremented when the post is destroyed' do
    @post.destroy
    assert Tag.find_by_name('cats').taggings_count == 0
  end

  test 'counter cache is decremented when the post is deleted through the association' do
    tag = Tag.find_by_name('cats')
    tag.posts.delete(@post)
    assert tag.reload.taggings_count == 0
  end

  test 'counter cache is decremented when the post is deleted' do
    @post.delete
    assert Tag.find_by_name('cats').taggings_count == 0
  end

end