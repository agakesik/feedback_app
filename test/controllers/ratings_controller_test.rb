require 'test_helper'

class RatingsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @average_user = users(:aga)
    @admin = users(:admin)
    @coach = users(:coach)
    @skill = skills(:plowstop)
    @rating_value = rating_values(:raw)
  end

  test "should redirect action new when not logged in as coach" do
    get root_url
    get path_to_new_rating(@average_user, @skill)
    assert_redirected_to login_url
    log_in_as(@average_user)
    get path_to_new_rating(@average_user, @skill)
    assert_redirected_to root_url
    log_in_as(@admin)
    get path_to_new_rating(@average_user, @skill)
    assert_redirected_to root_url
    log_in_as(@coach)
    get path_to_new_rating(@average_user, @skill)
    assert_template 'ratings/new'
  end

  test "should not allow new rating be edited via the web" do
    log_in_as(@average_user)
    assert_not @average_user.coach?
    assert_no_difference "Rating.count" do
      post ratings_path, params: { rating: { user_id: @average_user.id,
                                             skill_id: @skill.id,
                                            rating_value_id: @rating_value.id  } }
    end
    assert_redirected_to root_url
    log_in_as(@coach)
    assert @coach.coach?
    assert_difference 'Rating.count', 1 do
      post ratings_path, params: { rating: { user_id: @average_user.id,
                                             skill_id: @skill.id,
                                            rating_value_id: @rating_value.id } }
    end
  end

end
