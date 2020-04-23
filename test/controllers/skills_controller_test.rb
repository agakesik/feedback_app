require 'test_helper'

class SkillsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @average_user = users(:aga)
    @admin = users(:admin)
    @coach = users(:coach)
    @skill = skills(:plowstop)
    @category = skills_categories(:basic)
  end

  test "should redirect skill index page when not logged in as coach" do
    get skills_path
    assert_redirected_to login_url
    log_in_as(@average_user)
    get skills_path
    assert_redirected_to root_url
    log_in_as(@admin)
    get skills_path
    assert_redirected_to root_url
    log_in_as(@coach)
    get skills_path
    assert_template 'skills/index'
  end

  test "should not allow to destroy skill when not logged in as coach" do
    assert_no_difference 'Skill.count' do
      delete skill_path(@skill)
    end
    log_in_as(@average_user)
    assert_no_difference 'Skill.count' do
      delete skill_path(@skill)
    end
    log_in_as(@admin)
    assert_no_difference 'Skill.count' do
      delete skill_path(@skill)
    end
    log_in_as(@coach)
    assert_difference 'Skill.count', -1 do
      delete skill_path(@skill)
    end
  end

  test "should redirect new skill page when not logged in as coach" do
    get new_skill_path
    assert_redirected_to login_url
    log_in_as(@average_user)
    get new_skill_path
    assert_redirected_to root_url
    log_in_as(@admin)
    get new_skill_path
    assert_redirected_to root_url
    log_in_as(@coach)
    get new_skill_path
    assert_template 'skills/new'
  end

  test "should not allow creating new skill via web" do
    assert_no_difference 'Skill.count' do
      post skills_path, params: { skill: { name: "new skill",
                                           skills_category_id: @category.id } }
    end
    log_in_as(@average_user)
    assert_no_difference 'Skill.count' do
      post skills_path, params: { skill: { name: "new skill",
                                           skills_category_id: @category.id } }
    end
    log_in_as(@admin)
    assert_no_difference 'Skill.count' do
      post skills_path, params: { skill: { name: "new skill",
                                           skills_category_id: @category.id } }
    end
    log_in_as(@coach)
    assert_difference 'Skill.count', 1 do
      post skills_path, params: { skill: { name: "new skill",
                                           skills_category_id: @category.id } }
    end
  end

end
