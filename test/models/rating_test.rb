require 'test_helper'

class RatingTest < ActiveSupport::TestCase

  def setup
    @user = users(:aga)
    @skill = skills(:plowstop)
    @rating_value = rating_values(:raw)
    @rating = Rating.new(user_id: @user.id, skill_id: @skill.id,
                         rating_value_id: @rating_value.id)
  end

  test "should be valid" do
    @rating.valid?
  end


  test "rating should belong user" do
    @rating.user_id = nil
    assert_not @rating.valid?
  end

  test "rating should belong to skill" do
    @rating.skill_id = nil
    assert_not @rating.valid?
  end

  test "associated ratings should be destroyed with user" do
    @user.ratings.create!(skill_id: @skill.id, rating_value_id: @rating_value.id)
    assert_difference 'Rating.count', -1 do
      @user.destroy
    end
  end

  test "associated ratings should be destroyed with skill" do
    @skill.ratings.create!(user_id: @user.id, rating_value_id: @rating_value.id)
    assert_difference 'Rating.count', -1 do
      @skill.destroy
    end
  end

end
