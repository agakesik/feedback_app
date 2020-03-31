class SkillsController < ApplicationController
  def index
    @skills_categories = SkillsCategory.all
  end

  def show
    @skill = Skill.find(params[:id])
  end
end
