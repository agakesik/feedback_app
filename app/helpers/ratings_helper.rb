module RatingsHelper

  def rating_value(user, skill)
    rating = user.ratings.where(skill_id: skill.id).first
    if rating
      rating.value
    else
      " - "
    end
  end

  def path_to_new_rating(user, skill)
    previous_url = request.original_url unless request.nil?
    new_rating_path(user_id: user.id, skill_id: skill.id,
                    previous_url: request.original_url)
  end
end
