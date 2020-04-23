require 'test_helper'

class SkillCreateTest < ActionDispatch::IntegrationTest

  def setup
    @skills_category = skills_categories(:basic)
    @coach = users(:coach)
  end

  test "invalid skill information" do
    log_in_as(@coach)
    get new_skill_path
    assert_no_difference 'Skill.count' do
      post skills_path, params: { skill: { name: "",
                                          skills_category_id: 0 } }
    end
    assert_template 'skills/new'
    assert_select 'div.error-explanation'
  end

  test "valid skill information" do
    log_in_as(@coach)
    get new_skill_path
    assert_difference 'Skill.count', 1 do
      post skills_path, params: { skill: { name: "Skill 1",
                                    skills_category_id: @skills_category.id } }

    end
  end
end
