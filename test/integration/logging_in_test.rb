require 'test_helper'

class LoggingInTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:aga)
    skater_status = skater_statuses(:SS1)
    @new_user = User.create(name: "new", skater_status_id: skater_status.id,
                            email: "e@m.c")
  end

  test "test valid log in" do
    get login_path
    assert_template 'sessions/new'
    assert @user.authenticate("password")
    post login_path, params: { session: {email: @user.email, password: "password"}}
    assert is_logged_in?
    assert_redirected_to root_url
    follow_redirect!
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(@user)
  end

  test "invalid password" do
    post login_path, params: { session: {email: @user.email, password: " "}}
    assert_template 'sessions/new'
    assert_select 'div.alert-danger'
  end

  test "login for unactivated account" do
    post login_path, params: { session: {email: @new_user.email, password: " "}}
    assert_template 'sessions/new'
    assert_select 'div.alert-info'
  end
end
