class FriendshipsController < ApplicationController
  
  def destroy
    @friendships = Friendship.where("(user_id = ? AND friend_id = ?) OR (user_id = ? AND friend_id = ?)", current_user.id, params[:id], params[:id], current_user.id)
    
    if @friendships.destroy_all
      flash[:notice] = "You are no longer friend with that person."
      redirect_back(fallback_location: root_path)
    else
      flash[:notice] = "Cannot unfriend."
      redirect_back(fallback_location: root_path)
    end
    
  end

end
