# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Users
user = ["Kaczor Donald", "Hyzio", "Dyzio", "Myszka Mickey"]
user.each do |name|
  User.create(name: name)
end

skills_category = ["Basic Skating Skills", "Recovery tactics",
                   "Balance and Agility", "Pack skills and Interactions",
                   "Blocking" "Nasze"]
skills_category.each do |name|
  SkillsCategory.create(name: name)
end

skills1 = ["Skating posture", "Stride", "Crossovers", "Speed endurance",
          "T-stop", "Plowstop"]
skills1.each do |name|
  Skill.create(name: name, skills_category_id: 1)
end

Skill.create(name: "Knee taps", skills_category_id: 2)
Skill.create(name: "Hopping", skills_category_id: 3)
Skill.create(name: "Whips", skills_category_id: 4)
Skill.create(name: "Taking hits", skills_category_id: 5)
