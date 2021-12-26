class CommentsController < ApplicationController
  include CommentsHelper
  
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user, only: :destroy 

  def create
    @comment = current_user.comments.build(comment_params)
    if @comment.save
      redirect_back(fallback_location: root_path)
    else 
      redirect_back(fallback_location: root_path)
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
