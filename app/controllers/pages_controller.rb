class PagesController < ApplicationController
  def home
    @users = User.all
    @skill_categories = SkillsCategory.all
  end

  def help
  end

  def menu
  end

  def admin
  end
end
