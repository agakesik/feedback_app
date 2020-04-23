require 'test_helper'

class UserShowTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:aga)
    @admin = users(:admin)
    @coach = users(:coach)
  end

  test "show user's page" do
    log_in_as(@coach)
    get user_path(@user)
    assert_template 'users/show'
    assert_match @user.name, response.body
    Skill.all.each do |skill|
      assert_match skill.name, response.body
      assert_select 'a[href=?]', path_to_new_rating(@user, skill)
    end
  end

  test "delete user should only be visible to admin" do
    log_in_as(@admin)
    get user_path(@user)
    assert_select 'a[href=?]', user_path(@user), text: "usuń"
    assert_difference 'User.count', -1 do
      delete user_path(@user)
    end
    assert_redirected_to users_path
    follow_redirect!
    assert_select 'div.alert-info'
  end
end
