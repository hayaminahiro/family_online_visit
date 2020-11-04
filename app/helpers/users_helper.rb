module UsersHelper
  # マイページ表示用
  def user_icon_image(user)
    if user.image?
      image_tag user.image.url, id: :img_prev, class: "user-profile-image"
    else
      image_tag 'https://img-photo.s3-ap-northeast-1.amazonaws.com/uploads/content_image/user_default.png', id: :img_prev, class: "user-profile-image"
    end
  end
  # ユーザー編集画面用
  def user_icon_edit(user)
    if user.image?
      image_tag user.image.url, id: :img_prev, class: "user-edit-image", style: "width: 210px;
      height: 210px;
      border-radius: 50%;
      display: inline-block;
      object-fit: cover;
      margin-top:20px;"
    else
      image_tag 'https://img-photo.s3-ap-northeast-1.amazonaws.com/uploads/content_image/user_default.png', id: :img_prev, class: "user-profile-image image is-rounded is-128x128", style: "border-radius:100%;"
    end
  end
end
