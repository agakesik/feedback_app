require 'test_helper'

class HomePageTest < ActionDispatch::IntegrationTest

  def setup
    @admin = users(:aga)
  end

  test "home page should show users, skills and ratings for logged in user" do
    log_in_as(@admin)
    assert is_logged_in?
    get root_url
    # assert_template 'pages/home'
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
    assert_template 'sessions/new'
  end

end
