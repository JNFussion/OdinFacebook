class FriendRequestsController < ApplicationController
  
  def create
    @friend_request = current_user.friend_requests_as_requestor.new(friend_request_params)

    if @friend_request.save
      flash[:notice] = "Friend request has been sent."
      redirect_back(fallback_location: root_path)
    else
      flash[:alert] = "Friend request cannot be sent."
      redirect_back(fallback_location: root_path)
    end
  end

  def update
    @friend_request = FriendRequest.find(params[:id])

    if @friend_request.accepted!
      flash[:notice] = "Friend request accepted."
      redirect_back(fallback_location: root_path)
    else
      flash[:notice] = "Friend request cannot be accepted."
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @friend_request = FriendRequest.find(params[:id])
    @friend_request.destroy
  end

  private
  def friend_request_params
    params.require(:friend_request).permit(:requestor_id, :receiver_id)
  end
end
