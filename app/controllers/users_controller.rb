class UsersController < ApplicationController

  def index
    @skater_statuses = SkaterStatus.all

  end

  def show
    @user = User.find(params[:id])
    @skill_categories = SkillsCategory.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Człowiek dodany"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "Profil zmieniony"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:info] = "user usunięty"
    redirect_to users_path
  end

  private

    def user_params
      params.require(:user).permit(:name, :skater_status_id)
    end
end
