class UsersController < ApplicationController
  before_action :authenticate_user!
  def index
    @users = User.where.not(id: current_user).includes(:friend_requests_as_requestor).order(:id).with_attached_avatar
  end

  def show
    @user = User.includes(posts: {author: {avatar_attachment: :blob}}, friends: {avatar_attachment: :blob}, avatar_attachment: :blob).order("posts.created_at DESC").find(params[:id])
    @votes = Like.where(user: current_user, posts: @user.posts)
  end

  def current_user
    @current_user ||= super.tap do |user|
      ::ActiveRecord::Associations::Preloader.new.preload(user, :friends)
      ::ActiveRecord::Associations::Preloader.new.preload(user, :receivers)
    end
  end  
end
