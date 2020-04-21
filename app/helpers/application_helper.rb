module ApplicationHelper

  # Returns page type: spreadshit or single page
  def page_type(page_type = '')
    if page_type.empty?
      "single-page"
    else
      "spreadsheet-page"
    end
  end

  def inside_layout(layout = "application", &block)
    render inline: capture(&block), layout: "layouts/#{layout}"
  end

  def add_button(description, controller)
    link_to description, {controller: controller, action: :new},
                         class: "button add"
  end

  def rating_cell(user, skill, full = false )
    name = "-"
    background_color = nil
    value = show_rating_value(user, skill)

    if show_rating_value(user, skill)
      name = value.value.to_s
      background_color = "background-color: #{value.color}"
      name += ". #{value.name}" if full
    end
    link_to(path_to_new_rating(user, skill)) do
      content_tag(:div, name,
              class: "cell rating-cell",
              style: background_color )
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

  def skill_category_cell(skill_category)
    content_tag :div, skill_category.name, class: "cell skill-category-cell"
  end
end
