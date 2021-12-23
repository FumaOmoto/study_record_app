require "test_helper"

class UsersShowTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
    @admin = users(:archer)
    @first_page_of_posts = Post.paginate(page: 1)
  end

  test "should including pagination" do
    get user_path(@user)
    assert_template "users/show"
    assert_select "div.pagination", count: 1
  end

  test "should including post link" do
    get user_path(@user)
    assert_template "users/show"
    @first_page_of_posts.each do |post|
      assert_select "a[href=?]", post_path(post), text: post.title
    end
  end

  test "should including delete link when correct user" do
    log_in_as @user
    get user_path(@user)
    assert_template "users/show"
    @first_page_of_posts.each do |post|
      assert_select "a[data-confirm=本当に削除しますか？]", text: "削除"
    end
    delete user_path(@user)
    log_in_as @admin
    get user_path(@user)
    assert_template "users/show"
    @first_page_of_posts.each do |post|
      assert_select "a[data-confirm=本当に削除しますか？]", text: "削除"
    end
  end
end
