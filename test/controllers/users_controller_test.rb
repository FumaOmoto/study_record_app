require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
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
end
