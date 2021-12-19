require "test_helper"

class PostsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
    @other_user = users(:lana)
    @post = posts(:doggo) #michaelのpost
    @admin = users(:archer) #管理者
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

  test "destroy should redirect when not correct user" do
    log_in_as @other_user
    assert_no_difference "Post.count" do
      delete post_path(@post)
    end
    assert_redirected_to has_this_post(@post)
    follow_redirect!
    assert_select "div.alert-danger"
  end

  test "destroy should delete post when correct user" do
    log_in_as @user
    assert_difference "Post.count", -1 do
      delete post_path(@post)
    end
    assert_redirected_to has_this_post(@post)
    follow_redirect!
    assert_select "div.alert-success"
  end

  test "destroy should delete post when admin" do
    log_in_as @admin
    assert_difference "Post.count", -1 do
      delete post_path(@post)
    end
    assert_redirected_to has_this_post(@post)
    follow_redirect!
    assert_select "div.alert-success"
  end
end
