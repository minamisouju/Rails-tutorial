require 'test_helper'

class ReplyPostTest < ActiveSupport::TestCase
  def setup
    @micropost = microposts(:orange)
    @reply_post = @micropost.reply_posts.build(user_id: 1)
  end

  test "should be valid" do
    assert @reply_post.valid?
  end

  test "micropost_id should be present" do
    @reply_post.micropost_id = nil
    assert_not @reply_post.valid?
  end

  test "user_id should be present" do
    @reply_post.user_id = nil
    assert_not @reply_post.valid?
  end
end
