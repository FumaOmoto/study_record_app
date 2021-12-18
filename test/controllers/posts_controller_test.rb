require "test_helper"

class PostsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
    @post = posts(:doggo)
  end

  test "create should render new when post failed" do
    log_in_as @user
    post posts_path, params: {post: {title: "invalid", body:" ",
                                    user_id: @post.user.id}}
    assert_template "posts/new"
  end

  test "create should redirect to login_path when not logged in" do
    assert_no_difference "Post.count" do
      post posts_path, params: {post: {title: "this is title", body: "this is body",
                                       user_id: @post.user.id}}
    end
    assert_redirected_to login_url
  end

  test "destroy should redirect to login_path when not logged in" do
    assert_no_difference "Post.count" do
      delete post_path(@post)
    end
    assert_redirected_to login_url
  end
end
