require "test_helper"

class UsersIndexTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
    @other_user = users(:archer) #管理者ユーザ
    @users = User.paginate(page: 1)
  end

  test "should index including pagination" do
    log_in_as @other_user
    get users_path
    assert_template "users/index"
    assert_select "div.pagination", count: 2
    @users.each do |user|
      assert_select "a[href=?]", user_path(user), text: user.name
    end
  end
end
