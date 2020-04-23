class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy,
                                        :show, :new, :create]
  before_action :correct_user, only: [:show, :edit, :update]
  before_action :coach_or_admin_only, only: [:index]
  before_action :coach_only, only: [:new, :create]
  before_action :admin_only, only: [:destroy]

  def index
    @skater_statuses = SkaterStatus.all
    render layout: "two_column_page"
  end

  def show
    @user = User.find(params[:id])
    @skill_categories = SkillsCategory.all
    render layout: "two_column_page"
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
      params.require(:user).permit(:name, :skater_status_id, :email, :password,
                                   :password_confirmation)
    end
end
