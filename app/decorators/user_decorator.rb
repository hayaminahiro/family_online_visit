# frozen_string_literal: true

module UserDecorator
  # facility_idごとにグループ分け
  def grouped_facility
    informations = Information.where(facility_id: current_user.facilities).where(status: "others")
    informations.group_by(&:facility_id)
  end

  # 自分が登録している施設のお知らせで、statusがothersであるものを全て取得
  def mypage_informations(id)
    Information.where(facility_id: id).where(status: "others")
  end

  # 施設iconを表示
  def mypage_facilities_icon(id)
    facility = Facility.find(id)
    return image_tag facility.icon.url, class: "mypage-facility-icon-image" if facility.icon?
    image_tag 'https://img-photo.s3-ap-northeast-1.amazonaws.com/uploads/content_image/facility_default.png', class: "mypage-facility-icon-image"
  end

  # お知らせiconを表示
  def mypage_informations_icon(id)
    return image_tag id.image.url, class: "mypage-info-icon-image" if id.image?
    image_tag 'https://bulma.io/images/placeholders/128x128.png', class: "mypage-info-icon-image"
  end

  def reservation_calendar
    Reservation.where.not(calendar_day: nil)
  end

  # マイページ表示用
  def user_icon_image
    if image?
      image_tag image.url, id: :img_prev, class: "user-profile-image"
    else
      image_tag 'https://img-photo.s3-ap-northeast-1.amazonaws.com/uploads/content_image/user_default.png', id: :img_prev, class: "user-profile-image"
    end
  end
  # ユーザー編集画面用
  def user_icon_edit
    if image?
      image_tag image.url, id: :img_prev, class: "user-edit-image"
    else
      image_tag 'https://img-photo.s3-ap-northeast-1.amazonaws.com/uploads/content_image/user_default.png', id: :img_prev, class: "user-edit-image"
    end
  end

  def user_icon_mobile
    if image?
      image_tag image.url, id: :img_prev, class: "user-icon-image", onClick:"$('.user_img').click()"
    else
      image_tag 'https://img-photo.s3-ap-northeast-1.amazonaws.com/uploads/content_image/user_default.png', id: :img_prev, class: "user-icon-image", onClick:"$('.user_img').click()"
    end
  end
end
