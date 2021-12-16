class PostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  
  def create 
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = "投稿しました！"
      redirect_to current_user
    else
    
    end
  end

  def destroy

  end

  private

    def post_params
      params.require(:post).permit(:title, :body)
    end
end
