require 'test_helper'

class SkillsIndexTest < ActionDispatch::IntegrationTest

  test "should list all skills with skills categories" do
    get skills_path
    Skill.all.each do |skill|
      assert_select 'a[href=?]', skill_path(skill), text: skill.name
    end
    SkillsCategory.all.each do |category|
      assert_match category.name, response.body
    end
    assert_select 'a.button', "DODAJ skilla"
  end
end
