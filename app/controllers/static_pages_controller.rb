class StaticPagesController < ApplicationController
  def home
    @user = current_user if logged_in?
  end

  def help
    @user = current_user if logged_in?
  end

  def about
    @user = current_user if logged_in?
  end
end
