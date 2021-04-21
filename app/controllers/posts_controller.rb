class PostsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @posts = Post.where(author: current_user.friends).order(created_at: :desc)
    @post = Post.new
  end
  
  def show
    @post = Post.find(params[:id])
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
      redirect_to post_path(@post)
    else
      flash[:alert] = "Something went wrong."
      render :new
    end
  end

  def update
  end

  def destroy
  end

  private

  def post_params
    params.require(:post).permit(:user_id, :content)
  end
end
