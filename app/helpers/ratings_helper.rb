module RatingsHelper

  def rating_value(user, skill)
    rating = user.ratings.where(skill_id: skill.id).first
    if rating
      rating.value
    else
      " - "
    end
  end
end
