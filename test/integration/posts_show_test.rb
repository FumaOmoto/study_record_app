require "test_helper"

class PostsShowTest < ActionDispatch::IntegrationTest
  def setup
    @post = posts(:doggo)
  end

  test "should show post info even when not logged in" do
    get post_path(@post)
    assert_template "posts/show"
    assert_select "div.user-info"
    assert_select "div.post-info"
  end
end
