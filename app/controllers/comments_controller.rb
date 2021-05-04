class CommentsController < ApplicationController
  before_action :find_commentable

  def new
    @comment = Comment.new
  end

  def create
    @comment = @commentable.comments.new comment_params
    @comment.author = current_user
    if @comment.save
      redirect_to(post_path(@comment.find_post), notice: 'Your comment was successfully posted!')
    else
      redirect_back(fallback_location: root_path, notice: "Your comment wasn't posted!")
    end
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])
    if params[:removed]
      if @comment.update(body: "REMOVED")
        redirect_to(post_path(@comment.find_post), notice: 'Your comment was successfully update!')
      else
        render :edit
      end
    else
      if @comment.update(comment_params)
        redirect_to(post_path(@comment.find_post), notice: 'Your comment was successfully update!')
      else
        render :edit
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def find_commentable
    @commentable = Comment.find_by_id(params[:comment_id]) if params[:comment_id]
    @commentable = Post.find_by_id(params[:post_id]) if params[:post_id]
  end

end
