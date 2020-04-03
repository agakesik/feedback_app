class RatingsController < ApplicationController

  def new
    @user = User.find(params[:user_id])
    @skill = Skill.find(params[:skill_id])
    @rating = Rating.new
  end

  def create
    @rating = Rating.new(rating_params)
    if @rating.save
      redirect_to root_url
      flash[:success] = "Ocena dodana"
    else
      flash[:danger] = "wystąpił jakiś błąd :c"
      redirect_to root_url
    end
  end

  private

    def rating_params
      params.require(:rating).permit(:value, :user_id, :skill_id)
    end

end
