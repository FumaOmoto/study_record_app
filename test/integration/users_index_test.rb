require "test_helper"

class UsersIndexTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
    @other_user = users(:archer) #管理者ユーザ
    @first_page_of_users = User.paginate(page: 1)
  end

  test "should index including pagination, user link and user delete link when admin" do
    log_in_as @other_user
    get users_path
    assert_template "users/index"
    assert_select "div.pagination", count: 2
    @first_page_of_users.each do |user|
      assert_select "a[href=?]", user_path(user), text: user.name
      unless user == @other_user
        assert_select "a[href=?]", user_path(user), text: "削除"
      end
    end
    assert_difference "User.count", -1 do
      delete user_path(@user)
    end
  end

  test "should index not including delete link when logged in as non-admin" do
    log_in_as @user
    get users_path
    assert_select "a", text: "delete", count: 0
  end
end
