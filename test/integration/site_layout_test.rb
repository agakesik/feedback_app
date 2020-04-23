require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest

  def setup
    @admin = users(:admin)
    @coach = users(:coach)
    @normal_user = users(:aga)
  end

  test 'layout content when not logged in' do
    get root_path
    assert_redirected_to login_path
    follow_redirect!
    assert_select "div.content-container"
    assert_select "header"
    assert_select "div.sidebar"
    assert_select "a[href=?]", root_url, count: 2
    assert_select "a[href=?]", login_path, count: 1
    assert_select "a[href=?]", help_path, count: 1
  end

  test 'layout should show basic content when logged in' do
    log_in_as(@normal_user)
    get root_path
    assert_select "a[href=?]", user_path(@normal_user)
    assert_select "div.logged-in-content"
    assert_select "div.admin-content", count: 0
    assert_select "div.coach-content", count: 0
  end

  test "layout should show admin content when logged in as admin" do
    log_in_as(@admin)
    get root_path
    assert_select "div.logged-in-content"
    assert_select "div.admin-content"
    assert_select "div.coach-content", count: 0
  end

  test "layout should show coach content when logged in as coach" do
    log_in_as(@coach)
    get root_path
    assert_select "div.logged-in-content"
    assert_select "div.admin-content", count: 0
    assert_select "div.coach-content"
  end
end
