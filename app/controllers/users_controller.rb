class UsersController < ApplicationController
  before_action :authenticate_user!
  def index
    @users = User.where.not(id: current_user).includes(:friend_requests_as_requestor).order(:id)
  end

  def show
    @user = User.find(params[:id])
  end

  def current_user
    @current_user ||= super.tap do |user|
      ::ActiveRecord::Associations::Preloader.new.preload(user, :friends)
      ::ActiveRecord::Associations::Preloader.new.preload(user, :receivers)
    end
  end  
end
