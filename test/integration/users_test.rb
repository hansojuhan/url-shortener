require "test_helper"

class UsersTest < ActionDispatch::IntegrationTest
  test "user can log in" do
    sign_in users(:one)
    get links_path
    assert_select "a", "Profile"
    assert_select "button", "Log Out"
  end

  test "guest user" do
    get links_path
    assert_select "a", "Sign Up"
    assert_select "a[href=?]", "/users/sign_in"
  end
end