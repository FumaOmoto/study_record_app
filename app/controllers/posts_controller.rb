class PostsController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :destroy]
  before_action :correct_user, only: [:destroy, :edit, :update]

  def show 
    @user = current_user if logged_in?
    @post = Post.find_by(id: params[:id])
    @comments = @post.comments.paginate(page: params[:page], per_page: 5)
    @comment_create = current_user.comments.build if logged_in?
  end

  def index 
    @user = current_user if logged_in?
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

  def edit
    @user = current_user
    @post = Post.find_by(id: params[:id])
  end

  def update
    @user = current_user
    @post = Post.find_by(id: params[:id])
    if @post.update(post_params)
      flash[:success] = "編集されました"
      redirect_to has_this_post(@post)
    else
      render "edit"
    end
  end

  def destroy
    @post = Post.find_by(id: params[:id])
    @post.destroy!
    flash[:success] = "削除されました"
    redirect_to has_this_post(@post)
  end

  def search
    @user = current_user if logged_in?
    @posts = Post.search(params[:keyword], params[:category])
    @posts = @posts.page(params[:page])
    @keyword = params[:keyword]
    @category = params[:category]
    render "index"
  end

  private

    def post_params
      params.require(:post).permit(:title, :body, :category)
    end

    def correct_user
      post = Post.find_by(id: params[:id])
      unless has_this_post?(post) || current_user.admin?
        flash[:danger] = "正しいユーザではありません"
        redirect_to has_this_post(post)
      end
    end
end
