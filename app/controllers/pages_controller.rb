class PagesController < ApplicationController
  before_action :logged_in_user, only: [:home, :admin]
  before_action :admin_only, only: :admin

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
