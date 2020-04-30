class PagesController < ApplicationController
  before_action :logged_in_user, only: [:home, :admin]
  before_action :admin_only, only: :admin

  def home
  end

  def help
  end

  def menu
  end

  def admin
  end
end
