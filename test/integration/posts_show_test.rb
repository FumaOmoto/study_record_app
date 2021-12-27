require "test_helper"

class PostsShowTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
    @post = posts(:other_user_post)
    @first_page_of_comments = @post.comments.paginate(page: 1, per_page: 5)
  end

  test "should show post info even when not logged in" do
    get post_path(@post)
    assert_template "posts/show"
    assert_select "div.user-info"
    assert_select "div.post-info"
  end

  test "should including comments' pagination" do
    get post_path(@post)
    assert_template "posts/show"
    assert_select "div.pagination", count: 1
  end

  test "comments' delete link when correct user or admin" do
    log_in_as @user
    get post_path(@post)
    @first_page_of_comments.each do |comment|
      assert_select "a[href=?]", user_path(@user)
      if has_this_comment?(comment)
        assert_select "a[href=?]", post_comment_path(@post, comment)
      else
        assert_select "a[href=?]", post_comment_path(@post, comment), count: 0
      end
    end
  end

  test "comment form when not logged in/logged in" do
    get post_path(@post)
    assert_select "div.create-comment", count: 0
    log_in_as @user
    get post_path(@post)
    assert_select "div.create-comment", count: 1
  end

  test "comments' pagination link followed by invalid comment create" do
    log_in_as @user
    get post_path(@post)
    post post_comments_path(@post), params: {comment: {content: "",
                                                       post_id: @post.id }}
    assert_redirected_to post_path(@post)
    follow_redirect!
    assert_select "a[href=?]", "/posts/#{@post.id}?page=1"
  end
end
