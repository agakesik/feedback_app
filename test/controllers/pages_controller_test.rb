require 'test_helper'

class PagesControllerTest < ActionDispatch::IntegrationTest

  def setup
    @average_user = users(:aga)
    @admin = users(:admin)
  end

  test "should redirect home page when not logged in" do
    get root_url
    assert_redirected_to login_url
  end

  test "should redirect admin  page when not logged in as admin" do
    get admin_path
    assert_redirected_to login_url
    log_in_as(@average_user)
    get admin_path
    assert_redirected_to root_url
    log_in_as(@admin)
    get admin_path
    assert_template 'pages/admin'
  end

end
