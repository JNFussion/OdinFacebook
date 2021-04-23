class LikesController < ApplicationController
  
  def create
    @post = Post.find(params[:post_id])
    @post.likes.create(user_id: current_user.id, vote: params[:vote])
    redirect_back(fallback_location: root_path)
   
  end

  def update
    @like = Like.find(params[:id])
    @like.liked? ? @like.disliked! : @like.liked!
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @like = Like.find(params[:id])
    @like.destroy
    redirect_back(fallback_location: root_path)
  end

end
