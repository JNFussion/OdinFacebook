module ApplicationHelper

  def post_photo(post)
    if post.photo.attached?
      post.photo
    else
      post.url_photo
    end
  end
  
  
  def user_avatar(user,size=256)
    if user.avatar.attached?
      user.avatar.variant(resize: "#{size}x#{size}")
    else
      user.gravatar_url(size: size)
    end
  end
end
