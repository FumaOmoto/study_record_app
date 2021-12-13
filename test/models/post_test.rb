require "test_helper"

class PostTest < ActiveSupport::TestCase
  def setup 
    @user = users(:michael)
    @post = @user.posts.build(title: "this is title",
                              body: "this is body")
  end

  test "should be valid" do
    assert @post.valid?
  end

  test "user_id should be present" do
    @post.user_id = nil
    assert_not @post.valid?
  end

  test "title should be present" do
    @post.title = " "
    assert_not @post.valid?
  end

  test "body should be present" do
    @post.body = " "
    assert_not @post.valid?
  end

  test "title should be at most 30 characters" do
    @post.title = "a"*31
    assert_not @post.valid?
  end

  test "body should be at most 3000 characters" do
    @post.body = "a"*3001
    assert_not @post.valid?
  end
end
