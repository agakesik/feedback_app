# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# SkaterStatus
SkaterStatus.create(name: "ZERO kontaktu", color: "#dc5050")
SkaterStatus.create(name: "lekki kontakt", color: "#dcbe50")
SkaterStatus.create(name: "mocny kontakt", color: "#56dc50")
SkaterStatus.create(name: "gra", color: "#50a7dc")

# Users
user = ["Kaczor Donald", "Hyzio", "Dyzio", "Zyzio", "Myszka Mickey", "Pluto",
        "Sknerus", "Daisy", "Myszka Minnie", "Dziobak", "Goofy" ]
user.each do |name|
  User.create(name: name)
end

# Skills Categories
skills_category = ["Basic Skating Skills", "Recovery tactics",
                   "Balance and Agility", "Pack skills and Interactions",
                   "Blocking", "Nasze"]
skills_category.each do |name|
  SkillsCategory.create(name: name)
end

# Skills
skills1 = ["Skating posture", "Stride", "Crossovers", "Speed endurance",
          "T-stop", "Plowstop"]
skills1.each do |name|
  Skill.create(name: name, skills_category_id: 1)
end

Skill.create(name: "Knee taps", skills_category_id: 2)
Skill.create(name: "Hopping", skills_category_id: 3)
Skill.create(name: "Whips", skills_category_id: 4)
Skill.create(name: "Taking hits", skills_category_id: 5)
Skill.create(name: "kaczka", skills_category_id: 6)

5.times do |n|
  Skill.create(name: "recovery-#{n}", skills_category_id: 2)
  Skill.create(name: "balanse-#{n}", skills_category_id: 3)
  Skill.create(name: "pack-#{n}", skills_category_id: 4)
  Skill.create(name: "blocking-#{n}", skills_category_id: 5)
  Skill.create(name: "nasze-#{n}", skills_category_id: 6)
end

# Ratings value
RatingValue.create(value: 1, name: "raw meat", color: "#ffd7cc")
RatingValue.create(value: 2, name: "fresh meat", color: "#fff2cc")
RatingValue.create(value: 3, name: "rookie", color: "#ccffcf")
RatingValue.create(value: 4, name: "gracz derby", color: "#ccdeff")
RatingValue.create(value: 5, name: "Allstar", color: "#f4ccff")

# Ratings

10.times do |n|
  10.times do |m|
    Rating.create(rating_value_id: 1, user_id: n, skill_id: m*2)
    Rating.create(rating_value_id: 2, user_id: n, skill_id: m*2-1)
  end
end
