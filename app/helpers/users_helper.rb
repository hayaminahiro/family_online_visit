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
      image_tag user.image.url, id: :img_prev, class: "user-edit-image"
    else
      image_tag 'https://img-photo.s3-ap-northeast-1.amazonaws.com/uploads/content_image/user_default.png', id: :img_prev, class: "user-edit-image"
    end
  end
end
