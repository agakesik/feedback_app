require 'test_helper'

class NewRatingTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:aga)
    @skill = skills(:plowstop)
    @rating_value = rating_values(:raw)
    @coach = users(:coach)
  end

  test "path to new rating missing user or skill should redirect to root" do
    log_in_as(@coach)
    get new_rating_path(user_id: @user.id)
    assert_redirected_to root_url
    get new_rating_path(skill_id: @skill.id)
    assert_redirected_to root_url
  end

  test "test path_to_new_rating helper" do
    get root_url
    assert_match @user.id.to_s, path_to_new_rating(@user, @skill)
    assert_match @skill.id.to_s, path_to_new_rating(@user, @skill)
  end

  # test "invalid rating" do
  #   log_in_as(@coach)
  #   get user_path(@user)
  #   get path_to_new_rating(@user, @skill)
  #   post ratings_path, params: { rating: { user_id: 0,
  #                                          skill_id: 0,
  #                                          rating_value_id: 0} }
  #   # assert_redirected_to root_url
  #   follow_redirect!
  #   assert_select 'div.alert-danger'
  # end
  #
  # test "valid new rating" do
  #   log_in_as(@coach)
  #   get path_to_new_rating(@user, @skill)
  #   assert_match @user.name, response.body
  #   assert_match @skill.name, response.body
  #   post ratings_path, params: { rating: { user_id: @user.id,
  #                                          skill_id: @skill.id,
  #                                          rating_value_id: @rating_value.id } }
  #   follow_redirect!
  #   assert_select 'div.alert-success'
  # end
end
