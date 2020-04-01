require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest

  test "should see list of all users" do
    get users_path
    User.all.each do |user|
      assert_select 'a[href=?]', user_path(user), text: user.name
    end
  end
end
