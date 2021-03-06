module RatingsHelper

  def show_rating_value(user, skill)
    rating = user.ratings.where(skill_id: skill.id).first
    if rating
      rating.rating_value
    else
      nil
    end
  end


  def path_to_new_rating(user, skill)
    new_rating_path(user_id: user.id, skill_id: skill.id)
  end
end
