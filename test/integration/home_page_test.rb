require 'test_helper'

class HomePageTest < ActionDispatch::IntegrationTest

  test "home page should show users, skills and ratings" do
    get root_url
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

  test "template" do
    get root_url
    assert_template 'pages/home'
    assert_match  new_rating_path, response.body
  end
end
