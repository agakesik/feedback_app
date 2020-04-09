class RatingsController < ApplicationController
  before_action :get_skill_and_user, only: [:new]

  def new
    @rating = Rating.new
    @previous_url = params[:previous_url]
  end

  def create
    previous_url = params[:previous_url]
    @rating = Rating.new(rating_params)
    if @rating.save
      flash[:success] = "Ocena dodana"
      if previous_url
        redirect_to previous_url
      else
        redirect_to root_url
      end
    else
      flash[:danger] = "Ocena nie została dodana"
      if previous_url
        redirect_to previous_url
      else
        redirect_to root_url
      end
    end
  end

  private

    def get_skill_and_user
      if params[:user_id] && params[:skill_id]
        @user = User.find(params[:user_id])
        @skill = Skill.find(params[:skill_id])
      else
        redirect_to root_url
        flash[:danger] = "Błąd: do oceny potrzeba skatera i skilla"
      end
    end

    def rating_params
      params.require(:rating).permit(:value, :user_id, :skill_id)
    end

end
