class PostsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @posts = Post.includes(:author, :likes).where(author: current_user.friends).or(Post.where(author: current_user)).order(created_at: :desc)
    @post = Post.new
  end
  
  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
  end

  def new
    @post = current_user.posts.build
  end

  def edit
    @post = Post.find(params[:id])
  end

  def create
    @post = current_user.posts.build(post_params)
    p @post
    if @post.save
      flash[:notice] = "Post is published."
      redirect_to @post
    else
      flash[:alert] = "Something went wrong."
      render :new
    end
  end

  def update
    @post = Post.find(params[:id])

    if @post.update(post_params)
      flash[:notice] = "Post is updated."
      redirect_to @post
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to root_path
  end

  private

  def post_params
    params.require(:post).permit(:user_id, :content)
  end
end
