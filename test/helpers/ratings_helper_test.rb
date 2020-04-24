require 'test_helper'

class RatingHelperTest < ActionView::TestCase

  def setup
    @user = users(:aga)
    @skill = skills(:plowstop)
    @rating_value = rating_values(:raw)
    @new_rating_value = rating_values(:fresh)
    request = ActionDispatch::Request.new(:test)
  end

  test "helper show_rating_value" do
    assert_nil show_rating_value(@user, @skill)
    assert_difference 'Rating.count', 2 do
      Rating.create(user_id: @user.id, skill_id: @skill.id,
                    rating_value_id: @rating_value.id)
      Rating.create(user_id: @user.id, skill_id: @skill.id,
                    rating_value_id: @new_rating_value.id)
    end
    assert_equal @new_rating_value, show_rating_value(@user, @skill)
  end

end
