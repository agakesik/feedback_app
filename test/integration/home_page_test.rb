require 'test_helper'

class HomePageTest < ActionDispatch::IntegrationTest

  test "home page should show users, skills and ratings" do
    get root_url
    assert_template 'pages/home'
    User.all.each do |user|
      assert_match user.name, response.body
    end
    Skill.all.each do |skill|
      assert_match skill.name, response.body
    end
    SkillsCategory.all.each do |category|
      assert_match category.name, response.body
    end



  end
end
