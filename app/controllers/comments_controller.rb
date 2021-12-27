class CommentsController < ApplicationController  
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user, only: :destroy 

  def create
    @user = current_user
    @post = Post.find_by(id: params[:post_id])
    @comment_create = current_user.comments.build(comment_params)
    @comments = @post.comments.paginate(page: params[:page], per_page: 5)
    if @comment_create.save
      flash[:success] = "コメントしました"
      redirect_to @post
    else
      flash[:danger] = @comment_create.errors.full_messages.join(" ")
      redirect_to @post 
    end
  end

  def destroy
    @comment = Comment.find_by(params[:id])
    @comment.destroy!
    flash[:success] = "削除されました"
    redirect_to Post.find_by(id: params[:post_id])
  end

  private

    def comment_params
      params.require(:comment).permit(:content, :post_id)
    end

    def correct_user
      comment = Comment.find_by(id: params[:id])
      unless has_this_comment?(comment) || current_user.admin?
        flash[:danger] = "正しいユーザではありません"
        redirect_to Post.find_by(id: params[:post_id])
      end
    end
end
