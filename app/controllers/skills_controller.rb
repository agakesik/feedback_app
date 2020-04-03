class SkillsController < ApplicationController

  def index
    @skills_categories = SkillsCategory.all
  end

  def show
    @skill = Skill.find(params[:id])
    @users = User.all
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
    Skill.find(params[:id]).destroy
    flash[:info] = "skill usunięty"
    redirect_to skills_path
  end

  private

    def skill_params
      params.require(:skill).permit(:name, :skills_category_id)
    end
end
