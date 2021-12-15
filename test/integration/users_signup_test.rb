require "test_helper"

class UsersSignupTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
  end

  test "invalid signup information" do
    assert_no_difference "User.count" do
      post users_path, params: { user: { name: "invalid", email: "invalid@example",
                                          password: "inv_a", password_confirmation: "lid" }}                                  
    end
    assert_template "users/new"
    assert_select 'div#error_explanation'
  end

  test "valid signup information" do
    assert_difference "User.count", 1 do
      post users_path, params: { user: { name: "valid", email: "valid@example.com",
                                          password: "valid", password_confirmation: "valid" }}
    end
    follow_redirect!
    assert_template "users/show"
    assert is_logged_in?
    assert_not flash.empty?
    assert_select "div.alert-success"
  end

  test "valid/invalid signup when logged in" do
    post login_path, params: { session: { email: @user.email, 
                                          password: "password" }}
    assert_difference "User.count", 1 do
      post users_path, params: { user: { name: "valid", email: "valid@example.com",
                                          password: "valid", password_confirmation: "valid" }}
    end                                      
    assert_no_difference "User.count" do
      post users_path, params: { user: { name: "invalid", email: "invalid",
                                         password: "inv", password_confirmation: "invalid" }}
    end
  end
end
