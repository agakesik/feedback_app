class AccountActivationController < ApplicationController

  def edit
    @user = User.find_by(email: params[:email])
    if @user && @user.activated? && @user.authenticated?(params[:id])
      if @user.update(user_params)
        flash[:success] = "Hasło zapisane, konto aktywowane"
        redirect_to @user

      else
        render 'edit'
      end
    else
      flash[:danger] = "Wystąpił błąd z linkiem aktywacyjnym"
      redirect_to root_url
    end
  end



  private

    def user_params
      params.require(:user).permit(:password, :password_confirmation)
    end
end
