class PostsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @posts = Post.includes(author: {avatar_attachment: :blob}, photo_attachment: :blob ).where(author: current_user.friends).or(Post.where(author: current_user)).order(created_at: :desc)
    @votes = Like.where(user: current_user, post: @posts)
    @post = Post.new
  end
  
  def show
    @post = Post.includes(author: {avatar_attachment: :blob}, comments: { comments: [:comments, author: {avatar_attachment: :blob}], author: {avatar_attachment: :blob}}).find(params[:id])
    @votes = Like.where(user: current_user, post: @post)
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
    params.require(:post).permit(:user_id, :content, :url_photo, :photo)
  end
end
