require 'test_helper'

class SkillsIndexTest < ActionDispatch::IntegrationTest

  def setup
    @coach = users(:coach)
  end

  test "should list all skills with skills categories for coach" do
    log_in_as(@coach)
    get skills_path
    Skill.all.each do |skill|
      assert_select 'a[href=?]', skill_path(skill), text: skill.name
    end
    SkillsCategory.all.each do |category|
      assert_match category.name, response.body
    end
    assert_select 'a.text-button', "DODAJ SKILLA"
  end
end
