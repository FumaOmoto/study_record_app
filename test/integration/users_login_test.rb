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
    # 2番目のログアウト
    delete logout_path
  end

  test "home show login when not logged in" do
    post login_path, params: { session: { email: @user.email, 
                                          password: "password" }}
    get root_path
    assert_select "a.navbar-link", "ログアウト"
    delete logout_path
    get root_path
    assert_select "a.navbar-link", "ログイン"
  end

  test "should navbar show gravatar when logged in" do
    post login_path, params: { session: { email: @user.email, 
                                          password: "password" }}
    get root_path
    assert_select "img[alt=?]", @user.name
    get help_path
    assert_select "img[alt=?]", @user.name
    get about_path 
    assert_select "img[alt=?]", @user.name
    get signup_path
    assert_select "img[alt=?]", @user.name
    get users_path 
    assert_select "img[alt=?]", @user.name
    get user_path(@user)
    assert_select "img[alt=?]", @user.name
  end

  test "login with remembering" do
    log_in_as(@user, remember_me: "1")
    assert_not_empty cookies[:remember_token]
  end

  test "login without remembering" do
    log_in_as(@user, remember_me: "1")
    delete logout_path
    log_in_as(@user, remember_me: "0")
    assert_empty cookies[:remember_token]
  end

  test "should friendly-forwarding" do
    get users_path
    assert_redirected_to login_url
    post login_path, params: { session: { email: @user.email, 
                                          password: "password" }}
    assert_redirected_to users_url                       
  end
end
