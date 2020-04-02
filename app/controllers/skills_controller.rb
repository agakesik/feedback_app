class SkillsController < ApplicationController

  def index
    @skills_categories = SkillsCategory.all
  end

  def show
    @skill = Skill.find(params[:id])
  end

  def new
    @skill = Skill.new
  end

  def create
    @skill = Skill.new(skill_params)
    if @skill.save
      flash[:success] = "Udało się"
      redirect_to @skill
    else
      render 'new'
    end
  end

  def destroy
  end

  private

    def skill_params
      params.require(:skill).permit(:name, :skills_category_id)
    end
end
