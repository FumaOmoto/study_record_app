require "test_helper"

class UsersIndexTest < ActionDispatch::IntegrationTest
  def setup
    @users = User.paginate(page: 1)
  end

  test "should index including pagination" do
    get users_path
    assert_template "users/index"
    assert_select "div.pagination", count: 2
    @users.each do |user|
      assert_select "a[href=?]", user_path(user), text: user.name
    end
  end
end
