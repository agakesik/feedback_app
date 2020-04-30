require 'test_helper'

class ShowAllRatingsTest < ActionDispatch::IntegrationTest
  def setup
    @admin = users(:coach)
  end

  test "ratings#all should show users, skills and ratings for coach only" do
    log_in_as(@admin)
    assert is_logged_in?
    get all_ratings_path
    assert_template 'ratings/all'
    User.all.each do |user|
      assert_match user.name, response.body
      assert_match user.skater_status.color, response.body
    end
    Skill.all.each do |skill|
      assert_match skill.name, response.body
    end
    SkillsCategory.all.each do |category|
      assert_match category.name, response.body
    end
    Rating.all.each do |rating|
      assert_match rating.value, reponse.body
      assert_match rating.rating_value.color, response.body
    end
  end

  test "home page should show login template when not logged in" do
    get root_path
    assert_redirected_to login_path
  end
end
