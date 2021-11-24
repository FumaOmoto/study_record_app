require "test_helper"

class UsersSignupTest < ActionDispatch::IntegrationTest

  test "invalid signup information" do
    assert_no_difference "User.count" do
      post users_path, params: { user: { name: "invalid", email: "invalid@example",
                                          password: "inva", password_confirmation: "lid" }}                                  
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
    assert_not flash.empty?
    assert_select "div.alert-success"
  end
end
