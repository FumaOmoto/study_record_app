require "test_helper"

class CommentsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
    @other_user = users(:lana)
    @admin = users(:archer)
    @post = posts(:other_user_post)
    @comment = comments(:doggo)
  end

  test "create should redirect to login_path when not logged in" do
    assert_no_difference "Comment.count" do 
      post post_comments_path(@post), params: {comment: {content: "hello",
                                                        post_id: @post.id}}
    end                                                   
    assert_redirected_to login_path
  end

  test "valid comment create" do
    log_in_as @user
    assert_difference "Comment.count", 1 do
      post post_comments_path(@post), params: {comment: {content: "hello",
                                                         post_id: @post.id}}
    end                                                   
    assert_redirected_to post_path(@post)
  end

  test "invalid comment create" do
    log_in_as @user
    assert_no_difference "Comment.count" do
      post post_comments_path(@post), params: {comment: {content: "",
                                                         post_id: @post.id}}
    end
    assert_redirected_to post_path(@post)
  end

  test "destroy should redirect when not logged in" do
    delete post_comment_path(@post, @comment)
    assert_redirected_to login_path
  end

  test "destroy should redirect when not correct user or admin" do
    log_in_as @other_user
    delete post_comment_path(@post, @comment)
    assert_redirected_to post_path(@post)
  end

  test "destroy when correct user" do
    log_in_as @user
    delete post_comment_path(@post, @comment)
    assert_redirected_to post_path(@post)
  end

  test "destroy when admin" do
    log_in_as @admin
    delete post_comment_path(@post, @comment)
    assert_redirected_to post_path(@post)
  end
end
