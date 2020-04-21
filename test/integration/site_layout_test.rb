require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest

  test 'layout content' do
    get root_path
    assert_template 'pages/home'
    assert_select "div.content-container"
    assert_select "header"
    assert_select "div.sidebar"
    assert_select "a[href=?]", root_url, count: 1
    assert_select "a[href=?]", help_path, count: 1
    assert_select "a[href=?]", users_path, count: 1
    assert_select "a[href=?]", skills_path, count: 1
  end
end
