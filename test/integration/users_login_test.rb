require "test_helper"

class UsersLoginTest < ActionDispatch::IntegrationTest
  
  test "login with invalid information" do
    post login_path, params: { session: {email: " ", password: " "}}
    assert_template "sessions/new"
    assert_not flash.empty?
    assert_select  "div.alert-danger"
    get root_path
    assert flash.empty?
  end

end
