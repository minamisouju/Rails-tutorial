require 'test_helper'

class MicropostsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @micropost = microposts(:orange)
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'Micropost.count' do
      post microposts_path, params: { micropost: { content: "Lorem ipsum" } }
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Micropost.count' do
      delete micropost_path(@micropost)
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy for wrong micropost" do
    log_in_as(users(:michael))
    micropost = microposts(:ants)
    assert_no_difference 'Micropost.count' do
      delete micropost_path(micropost)
    end
    assert_redirected_to root_url
  end

  test "should set reply_post" do
    log_in_as(users(:michael))
    assert_no_difference 'ReplyPost.count' do
      post microposts_path, params: { micropost: { content: "test test @abcde TEST" } }
    end
    assert_difference 'ReplyPost.count', 1 do
      post microposts_path, params: { micropost: { content: "test test @Lana_Kane TEST" } }
    end
  end
end
