class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user && @user.activated
      if @user.authenticate(params[:session][:password])
        log_in @user
        flash[:success] = "Poprawne logowanie"
        redirect_to @user
      else
        flash[:danger] = "Błędne hasło"
        render 'new'
      end
    else
      flash[:info] = "Użytkownik nie istnieje lub nie jest aktywny"
      render 'new'
    end

  end

  def destroy
    log_out
    redirect_to root_path
  end
end
