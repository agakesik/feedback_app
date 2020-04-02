require 'test_helper'

class UserCreateTest < ActionDispatch::IntegrationTest

  test "Invalid user create information" do
    get new_user_path
    assert_no_difference 'User.count' do
      post users_path, params: { user: { name: "" } }
    end
    assert_template 'users/new'
    assert_select 'div.error-explanation'
  end

  test "valid user create information" do
    get new_user_path
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { name: "Example" } }
    end
    follow_redirect!
    assert_template 'users/show'
  end
end
