require 'test_helper'

class SkillsCategoryTest < ActiveSupport::TestCase

  def setup
    @category = SkillsCategory.new(name: "random category")
  end

  test "should be valid" do
    @category.valid?
  end

  test "name should be present and not too long" do
    @category.name = "          "
    assert_not @category.valid?
    @category.name = "a" * 51
    assert_not @category.valid?
  end

  test "name should be unique" do
    duplicate = @category.dup
    duplicate.name.upcase!
    @category.save
    assert_not duplicate.valid?
  end
end
