require 'test_helper'

class SkillShowTest < ActionDispatch::IntegrationTest

  def setup
    @skill = skills(:plowstop)
    @coach = users(:coach)
  end

  test "show skill's page - only coach should be able" do
    log_in_as(@coach)
    get skill_path(@skill)
    assert_template 'skills/show'
    assert_match @skill.name, response.body
    User.all.each do |user|
      assert_match user.name, response.body
      assert_select 'a[href=?]', path_to_new_rating(user, @skill)
    end
  end

  test "delete skill" do
    log_in_as(@coach)
    get skill_path(@skill)
    assert_select 'a[href=?]', skill_path(@skill), text: "usuń"
    assert_difference 'Skill.count', -1 do
      delete skill_path(@skill)
    end
    assert_redirected_to skills_path
    follow_redirect!
    assert_select 'div.alert-info'
  end
end
