require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:aga)
  end

  test "should get new" do
    get new_user_path
    assert_response :success
  end

end
