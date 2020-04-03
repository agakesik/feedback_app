require 'test_helper'

class NewRatingTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:aga)
    @skill = skills(:plowstop)
  end

  test "path to new rating missing user or skill should redirect to root" do
    get new_rating_path(user_id: @user.id)
    assert_redirected_to root_url
    get new_rating_path(skill_id: @skill.id)
    assert_redirected_to root_url
  end

  test "invalid rating" do
    get path_to_new_rating(@user, @skill)
    post ratings_path, params: { rating: { user_id: 0,
                                           skill_id: 0,
                                           value: 6 } }
    assert_redirected_to root_url
    follow_redirect!
    assert_select 'div.alert-danger'
  end

  test "valid new rating" do
    get path_to_new_rating(@user, @skill)
    assert_match @user.name, response.body
    assert_match @skill.name, response.body
    post ratings_path, params: { rating: { user_id: @user.id,
                                           skill_id: @skill.id,
                                           value: 1 } }
    assert_redirected_to root_url
    follow_redirect!
    assert_select 'div.alert-success'
  end
end
