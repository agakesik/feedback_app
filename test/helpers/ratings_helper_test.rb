require 'test_helper'

class RatingHelperTest < ActionView::TestCase

  def setup
    @user = users(:aga)
    @skill = skills(:plowstop)
    request = ActionDispatch::Request.new(:test)
  end

  test "rating_value test" do
    assert_match rating_value(@user, @skill), " - "
    assert_difference 'Rating.count', 2 do
      Rating.create(value: 1, user_id: @user.id, skill_id: @skill.id)
      Rating.create(value: 3, user_id: @user.id, skill_id: @skill.id)
    end
    assert_equal 3, rating_value(@user, @skill)
  end

end
