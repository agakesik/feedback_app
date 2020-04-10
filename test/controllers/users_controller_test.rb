require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:aga)
  end

  test "should get new, show, index and edit" do
    get new_user_path
    assert_response :success
    get user_path(@user)
    assert_response :success
    get users_path
    assert_response :success
    get edit_user_path(@user)
    assert_response :success
  end


end
