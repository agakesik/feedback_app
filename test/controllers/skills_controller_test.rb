require 'test_helper'

class SkillsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @average_user = users(:aga)
    @admin = users(:admin)
    @coach = users(:coach)
    @skill = skills(:plowstop)
    @category = skills_categories(:basic)
  end

  test "should redirect skill index page when not logged in as coach or admin" do
    get skills_path
    assert_redirected_to login_url
    log_in_as(@average_user)
    get skills_path
    assert_redirected_to root_url
    log_in_as(@admin)
    get skills_path
    assert_template 'skills/index'
    log_in_as(@coach)
    get skills_path
    assert_template 'skills/index'
  end

  test "should not allow to destroy skill when not logged in as admin" do
    assert_no_difference 'Skill.count' do
      delete skill_path(@skill)
    end
    log_in_as(@average_user)
    assert_no_difference 'Skill.count' do
      delete skill_path(@skill)
    end
    log_in_as(@admin)
    assert_difference 'Skill.count', -1 do
      delete skill_path(@skill)
    end
    log_in_as(@coach)
    assert_no_difference 'Skill.count' do
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

  test "should only allow editing skills to admin and coach" do
    # not logged in user
    patch skill_path(@skill), params: { skill: { name: "change skill",
                                         skills_category_id: @category.id } }
    assert_match @skill.reload.name, "plowstop"
    assert_redirected_to login_path
    # other users
    log_in_as(@average_user)
    patch skill_path(@skill), params: { skill: { name: "change skill",
                                         skills_category_id: @category.id } }
    assert_match @skill.reload.name, "plowstop"
    assert_redirected_to root_url
    # admin can change
    log_in_as(@admin)
    patch skill_path(@skill), params: { skill: { name: "change skill",
                                         skills_category_id: @category.id } }
    assert_match @skill.reload.name, "change skill"
    assert_redirected_to skill_path(@skill)
    # coach can change
    log_in_as(@coach)
    patch skill_path(@skill), params: { skill: { name: "change skill vol2",
                                         skills_category_id: @category.id } }
    assert_match @skill.reload.name, "change skill vol2"
    assert_redirected_to skill_path(@skill)
  end

end
