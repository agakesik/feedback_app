class AccountActivationsController < ApplicationController

  def edit
    @user = User.find_by(email: params[:email])
    if @user && @user.activating? && !@user.activated? && @user.authenticated?(:activation, params[:id])
    else
      flash[:danger] = "Wystąpił błąd z linkiem aktywacyjnym"
      redirect_to root_url
    end
  end

  def update
    @user = User.find_by(email: params[:email])
    if @user.update(user_params)
      flash[:success] = "Hasło zapisane, konto aktywowane"
      @user.activated = true
      log_in @user
      redirect_to @user

    else
      render 'edit'
    end
  end



  private

    def user_params
      params.require(:user).permit(:password, :password_confirmation, :activated)
    end
end
