class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :destroy]
  before_action :admin_user, only: :destroy

  def show
    @user = User.find(params[:id])
  end

  def index 
    @users = User.paginate(page: params[:page])
  end
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "スタレコへようこそ！"
      redirect_to user_path(@user)
    else
      render 'new'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "このユーザは削除されました"
    redirect_to users_path
  end

  private

    def user_params
      params.require(:user).permit( :name, :email, :password,
                                    :password_confirmation, )
    end

    #ログインしているか確認
    def logged_in_user
      redirect_to login_path unless logged_in?
    end

    #管理者かどうか確認
    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
end
