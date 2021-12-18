require "test_helper"

class NewPostTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
    @post = posts(:doggo)
  end

  test "should show error messages when failed to create post" do
    log_in_as @user
    post posts_path, params: {post: {title: "invalid", body:" ",
                                    user_id: @post.user.id}}
    assert_template "posts/new"
    assert_select "div#error_explanation"
  end
end
