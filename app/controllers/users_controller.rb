class UsersController < ApplicationController
  before_action :authenticate_user!
  def index
    @users = User.where.not(id: current_user).includes(:friend_requests_as_requestor).order(:id).with_attached_avatar
  end

  def show
    @user = User.includes(posts: {author: {avatar_attachment: :blob}}, friends: {avatar_attachment: :blob}, avatar_attachment: :blob).order("posts.created_at DESC").find(params[:id])
    @votes = Like.where(user: current_user, posts: @user.posts)
  end

  def edit_email
    @user = current_user
    render :edit_email
  end

  def update_email
    @user = current_user
    if @user.update_with_password(user_params)
      flash[:notice] = "Email has been uploaded"
      bypass_sign_in(@user)
      redirect_to root_path
    else
      render :edit_email
    end
  end

  def edit_avatar
    @user = current_user
    render :edit_avatar
  end

  def update_avatar
    @user = current_user
    if @user.update_without_password(user_params)
      flash[:notice] = "Avatar pictue has been uploaded"
      bypass_sign_in(@user)
      redirect_to root_path
    else
      render :edit_avatar
    end
  end

  def destroy_avatar
    current_user.avatar.purge
    redirect_to root_path
  end

  def edit
    @user = current_user
    render :edit_password
  end

  def update_password
    @user = current_user
    if @user.update_with_password(user_params)
      flash[:notice] = "Password has been changed"
      bypass_sign_in(@user)
      redirect_to root_path
    else
      render :edit_password
    end
  end


  def current_user
    @current_user ||= super.tap do |user|
      ::ActiveRecord::Associations::Preloader.new.preload(user, :friends)
      ::ActiveRecord::Associations::Preloader.new.preload(user, :receivers)
    end
  end  

  private

  def user_params
    params.require(:user).permit(:password, :password_confirmation, :current_password, :avatar, :email)
  end
end
