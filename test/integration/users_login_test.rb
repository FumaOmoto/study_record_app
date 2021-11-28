require "test_helper"

class UsersLoginTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
  end
  
  test "login with invalid information" do
    post login_path, params: { session: {email: " ", password: " "}}
    assert_template "sessions/new"
    assert_not flash.empty?
    assert_select  "div.alert-danger"
    get root_path
    assert flash.empty?
  end

  test "login with valid information followed by logout" do
    post login_path, params: { session: { email: @user.email, 
                                          password: "password" }}
    assert is_logged_in?
    assert_redirected_to @user
    follow_redirect!
    assert_template "users/show"
    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_path
  end
end
