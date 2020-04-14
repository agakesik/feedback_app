module ApplicationHelper

  # Returns page type: spreadshit or single page
  def page_type(page_type = '')
    if page_type.empty?
      "single-page"
    else
      "spreadsheet-page"
    end
  end

  def rating_cell(user, skill, full = false )
    # name = show_rating_value(user, skill).value
    # name += "." if full
    name = "-"
    color = "#bbb"
    value = show_rating_value(user, skill)

    if show_rating_value(user, skill)
      name = value.value.to_s
      color = value.color
      name += ". #{value.name}" if full
    end
    link_to(path_to_new_rating(user, skill)) do
      content_tag(:div, name,
              class: "cell rating-cell",
              style: "background-color: #{color}" )
    end
  end

  def user_cell(user)
    link_to(user_path(user)) do
      content_tag(:div, user.name, class: "cell user-cell",
                      style: "background-color: #{user.skater_status.color}" )
    end
  end

  def skill_cell(skill)
    link_to(skill_path(skill)) do
      content_tag(:div, skill.name, class: "cell skill-cell")
    end
  end
end
