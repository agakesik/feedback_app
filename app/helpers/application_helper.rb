module ApplicationHelper

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
    # link_to(path_to_new_rating(user, skill)) do
    content =  content_tag(:div, name, class: "cell rating-cell",
                           style: background_color)
    # end
    if current_user.coach?
      link_to content, path_to_new_rating(user, skill)
    else
      content
    end
  end

  def user_cell(user)
    content = content_tag(:div, user.name, class: "cell user-cell",
                    style: "background-color: #{user.skater_status.color}")
    if current_user.coach? || current_user.admin?
      link_to content, user_path(user)
    else
      content
    end
  end

  def skill_cell(skill)
    content =  content_tag(:div, skill.name, class: "cell skill-cell")
    if current_user.coach? || current_user.admin?
      link_to content, skill_path(skill)
    else
      content
    end
  end

  def skill_category_cell(skill_category)
    content_tag :div, skill_category.name, class: "cell skill-category-cell"
  end

  def link_cell(path, cell)
    if current_user.coach?
      link_to(path) do
        cell
      end
    else
      cell
    end
  end


  def check_if_authenticated
    if not logged_in?
      redirect_to login_path, alert: "please log in!"
    end
  end
end
