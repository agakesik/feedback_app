require 'test_helper'

class RatingTest < ActiveSupport::TestCase

  def setup
    @user = users(:aga)
    @skill = skills(:plowstop)
    @rating = Rating.new(value: 1, user_id: @user.id, skill_id: @skill.id)
  end

  test "should be valid" do
    @rating.valid?
  end

  test "rating should be in range (1..5)" do
    @rating.value = 2
    assert @rating.valid?
    @rating.value = 3
    assert @rating.valid?
    @rating.value = 4
    assert @rating.valid?
    @rating.value = 5
    assert @rating.valid?
    @rating.value = 6
    assert_not @rating.valid?
  end

  test "rating should belong user" do
    @rating.user_id = nil
    assert_not @rating.valid?
  end

  test "rating should belong to skill" do
    @rating.skill_id = nil
    assert_not @rating.valid?
  end

end
