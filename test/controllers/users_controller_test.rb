require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
    @other_user = users(:archer) #管理者ユーザ
  end
  
  test "should get signup" do
    get signup_path
    assert_response :success
  end

  test "should not allow the admin attribute to be edited when signup" do
    post users_path, params: { user: { name: "cracker", email: "cracker@example.com",
                                       password: "password", password_confirmation: "password",
                                       admin: true}}
    user = User.find_by(email: "cracker@example.com")
    assert_not user.admin?
  end

  test "should redirect destroy when not logged in" do 
    assert_no_difference "User.count" do
      delete user_path(@user)
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when not logged in as admin" do
    log_in_as(@user)
    assert_no_difference "User.count" do
      delete user_path(@user)
    end
    assert_redirected_to root_url
  end
end
