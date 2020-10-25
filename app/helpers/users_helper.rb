module UsersHelper
  def user_icon_image(user)
    if user.image?
      image_tag user.image.url, id: :icon_prev, class: "user-profile-image"
    else
      image_tag 'https://img-photo.s3-ap-northeast-1.amazonaws.com/uploads/content_image/user_default.png', id: :icon_prev, class: "user-profile-image"
    end
  end
end
