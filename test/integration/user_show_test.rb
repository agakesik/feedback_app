require 'test_helper'

class UserShowTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:aga)
  end

  test "show user's page" do
    get user_path(@user)
    assert_template 'users/show'
    assert_match @user.name, response.body
    assert_select 'a[href=?]', user_path(@user), text: "usuń"
    assert_difference 'User.count', -1 do
      delete user_path(@user)
    end
    assert_redirected_to users_path
    follow_redirect!
    assert_select 'div.alert-success'
  end
end
