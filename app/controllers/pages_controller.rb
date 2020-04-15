class PagesController < ApplicationController
  def home
    @skater_statuses = SkaterStatus.all
    @skill_categories = SkillsCategory.all
  end

  def help
  end

  def menu
  end

  def admin
  end
end
