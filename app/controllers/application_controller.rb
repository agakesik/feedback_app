class ApplicationController < ActionController::Base
  include SessionsHelper

  private

    # Before filters

    # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        store_location
        flash[:info] = "Please log in"
        redirect_to login_url
      end
    end

    def admin_only
      unless current_user.admin?
        flash[:danger] = "Dostepne tylko adminom"
        redirect_to root_url
      end
    end

    def coach_only
      unless current_user.coach?
        flash[:danger] = "Dostępne tylko trenerom"
        redirect_to root_url
      end
    end

    def coach_or_admin_only
      unless current_user.coach? || current_user.admin?
        flash[:danger] = "Dostępne tylko trenerom"
        redirect_to root_url
      end
    end

    def correct_user
      @user = User.find(params[:id])
      unless current_user.coach? || current_user.admin? || @user == current_user
        flash[:danger] = "Treść niedostępna"
        redirect_to root_url
      end
    end

end
