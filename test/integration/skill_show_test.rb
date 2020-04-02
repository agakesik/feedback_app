require 'test_helper'

class SkillShowTest < ActionDispatch::IntegrationTest

  def setup
    @skill = skills(:plowstop)
  end

  test "show skill's page" do
    get skill_path(@skill)
    assert_template 'skills/show'
    assert_match @skill.name, response.body
    assert_select 'a[href=?]', skill_path(@skill), text: "usuń"
    assert_difference 'Skill.count', -1 do
      delete skill_path(@skill)
    end
    assert_redirected_to skills_path
    follow_redirect!
    assert_select 'div.alert-info'
  end
end
