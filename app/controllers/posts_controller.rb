class PostsController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :destroy]

  def show 
    @user = current_user if logged_in?
    @post = current_user.posts.find_by(id: params[:id])
  end

  def new
    @user = current_user
    @post_create = current_user.posts.build
  end
  
  def create
    @user = current_user
    @post_create = current_user.posts.build(post_params)
    if @post_create.save
      flash[:success] = "投稿しました！"
      redirect_to current_user
    else
      render "new"
    end
  end

  def destroy

  end

  private

    def post_params
      params.require(:post).permit(:title, :body)
    end
end
