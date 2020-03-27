require 'test_helper'

class SkillTest < ActiveSupport::TestCase

  def setup
    @category = skills_categories(:cat1)
    @skill = Skill.new(name: "random skill", skills_category_id: @category.id)
  end

  test "should be valid" do
    assert @skill.valid?
  end

  test "skills_category_id should be present" do
    @skill.skills_category_id = nil
    assert_not @skill.valid?
  end

  test "name should be present and not too long" do
    @skill.name = "    "
    assert_not @skill.valid?
  end

  test "name should be unique" do
    duplicate = @skill.dup
    duplicate.name.upcase!
    @skill.save
    assert_not duplicate.valid?
  end

end
