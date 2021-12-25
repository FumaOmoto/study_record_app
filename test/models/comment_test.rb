require "test_helper"

class CommentTest < ActiveSupport::TestCase
  def setup
    @user = users(:michael)
    @other_user = users(:lana)
    @post = posts(:doggo)
    @comment = @other_user.comments.build(content: "valid", post_id: @post.id)
  end

  test "should be valid" do
    assert @comment.valid?
  end

  test "content should be present" do
    @comment.content = " "
    assert_not @comment.valid?
  end

  test "user_id should be present" do
    @comment.user_id = " "
    assert_not @comment.valid?
  end

  test "post_id should be present" do
    @comment.post_id = " "
    assert_not @comment.valid?
  end

  test "content should be at most 1000 characters" do
    @comment.content = "a"*1001
    assert_not @comment.valid?
  end

  test "comment's order should be most recent first" do
    assert_equal comments(:most_recent), Comment.first
  end
end
