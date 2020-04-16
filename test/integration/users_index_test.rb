require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest

  test "should see list of all users" do
    get users_path
    User.all.each do |user|
      assert_select 'a[href=?]', user_path(user), text: user.name
    end
    SkaterStatus.all.each do |status|
      assert_match status.name, response.body
    end
    assert_select 'a.button', "DODAJ człowieka"
  end
end
