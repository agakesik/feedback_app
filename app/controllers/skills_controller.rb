class SkillsController < ApplicationController
  before_action :logged_in_user, only: [:index, :destroy, :show, :new, :create,
                                         :edit, :update]
  before_action :coach_or_admin_only, only: [:index, :show, :edit, :update]
  before_action :coach_only, only: [:new, :create]
  before_action :admin_only, only: [:destroy]

  def index
    @skills_categories = SkillsCategory.all
    render layout: "two_column_page"
  end

  def show
    @skill = Skill.find(params[:id])
    @skater_statuses = SkaterStatus.all
    render layout: "two_column_page"
  end

  def new
    @skill = Skill.new
  end

  def create
    @skill = Skill.new(skill_params)
    if @skill.save
      flash[:success] = "Skill dodany"
      redirect_to @skill
    else
      render 'new'
    end
  end

  def edit
    @skill = Skill.find(params[:id])
  end

  def update
    @skill = Skill.find(params[:id])
    if @skill.update(skill_params)
      flash[:success] = "Profil zmieniony"
      redirect_to @skill
    else
      render 'edit'
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
