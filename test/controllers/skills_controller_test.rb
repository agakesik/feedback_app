require 'test_helper'

class SkillsControllerTest < ActionDispatch::IntegrationTest

  test "should get new" do
    get new_skill_path
    assert_response :success
  end

end
