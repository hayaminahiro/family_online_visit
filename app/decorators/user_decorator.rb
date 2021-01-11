# frozen_string_literal: true

module UserDecorator
  # facility_idごとにグループ分け
  def grouped_facility
    informations = Information.where(facility_id: current_user.facilities).where(status: "others")
    informations.group_by(&:facility_id)
  end

  # 自分が登録している施設のお知らせで、statusがothersであるものを全て取得
  def mypage_informations(id)
    Information.where(facility_id: id).where(status: "others").includes(:facility)
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
    if icon?
      image_tag icon.url, class: "user-profile-image"
    else
      image_tag 'https://img-photo.s3-ap-northeast-1.amazonaws.com/uploads/content_image/user_default.png', class: "user-profile-image"
    end
  end

  # ユーザー編集画面用
  def user_icon_edit
    if icon?
      image_tag icon.url, id: :icon_prev_0, class: "user-edit-image"
    else
      image_tag 'https://img-photo.s3-ap-northeast-1.amazonaws.com/uploads/content_image/user_default.png', id: :icon_prev_0, class: "user-edit-image"
    end
  end

  # ユーザー背景画像
  def user_background
    if image?
      image_tag image.url, class: "mypage-image"
    else
      month = Date.today.month
      if month.in?([ 12, 1, 2 ])
        image_tag 'https://img-photo.s3-ap-northeast-1.amazonaws.com/uploads/content_image/winter.jpg', class: "mypage-image"
      elsif month.in?([ 3, 4, 5 ])
        image_tag 'https://img-photo.s3-ap-northeast-1.amazonaws.com/uploads/content_image/spring.jpg', class: "mypage-image"
      elsif month.in?([ 6, 7, 8 ])
        image_tag 'https://img-photo.s3-ap-northeast-1.amazonaws.com/uploads/content_image/summer.jpg', class: "mypage-image"
      elsif month.in?([ 9, 10, 11 ])
        image_tag 'https://img-photo.s3-ap-northeast-1.amazonaws.com/uploads/content_image/+autumn.jpg', class: "mypage-image"
      end
    end
  end

  # ユーザー背景画像編集
  def user_background_edit
    if image?
      image_tag image.url, id: :img_prev_1, class: "user-bg-edit"
    else
      month = Date.today.month
      if month.in?([ 12, 1, 2 ])
        image_tag 'https://img-photo.s3-ap-northeast-1.amazonaws.com/uploads/content_image/winter.jpg', id: :img_prev_1, class: "user-bg-edit"
      elsif month.in?([ 3, 4, 5 ])
        image_tag 'https://img-photo.s3-ap-northeast-1.amazonaws.com/uploads/content_image/spring.jpg', id: :img_prev_1, class: "user-bg-edit"
      elsif month.in?([ 6, 7, 8 ])
        image_tag 'https://img-photo.s3-ap-northeast-1.amazonaws.com/uploads/content_image/summer.jpg', id: :img_prev_1, class: "user-bg-edit"
      elsif month.in?([ 9, 10, 11 ])
        image_tag 'https://img-photo.s3-ap-northeast-1.amazonaws.com/uploads/content_image/+autumn.jpg', id: :img_prev_1, class: "user-bg-edit"
      end
    end
  end

  # レスポンシブ（背景画像編集）
  def user_background_edit_responsive
    if image?
      image_tag image.url, id: :img_prev_0, class: "user-bg-edit-responsive", onClick: "$('#user_bg_img').click()"
    else
      month = Date.today.month
      if month.in?([ 12, 1, 2 ])
        image_tag 'https://img-photo.s3-ap-northeast-1.amazonaws.com/uploads/content_image/winter.jpg', id: :img_prev_0, class: "user-bg-edit-responsive", onClick: "$('#user_bg_img').click()"
      elsif month.in?([ 3, 4, 5 ])
        image_tag 'https://img-photo.s3-ap-northeast-1.amazonaws.com/uploads/content_image/spring.jpg', id: :img_prev_0, class: "user-bg-edit-responsive", onClick: "$('#user_bg_img').click()"
      elsif month.in?([ 6, 7, 8 ])
        image_tag 'https://img-photo.s3-ap-northeast-1.amazonaws.com/uploads/content_image/summer.jpg', id: :img_prev_0, class: "user-bg-edit-responsive", onClick: "$('#user_bg_img').click()"
      elsif month.in?([ 9, 10, 11 ])
        image_tag 'https://img-photo.s3-ap-northeast-1.amazonaws.com/uploads/content_image/+autumn.jpg', id: :img_prev_0, class: "user-bg-edit-responsive", onClick: "$('#user_bg_img').click()"
      end
    end
  end

  # レスポンシブ
  def user_icon_responsive
    if icon?
      image_tag icon.url, class: "user-icon-image"
    else
      image_tag 'https://img-photo.s3-ap-northeast-1.amazonaws.com/uploads/content_image/user_default.png', class: "user-icon-image"
    end
  end

  def user_icon_edit_responsive
    if icon?
      image_tag icon.url, id: :icon_prev_1, class: "user-icon-image", onClick: "$('.user_img').click()"
    else
      image_tag 'https://img-photo.s3-ap-northeast-1.amazonaws.com/uploads/content_image/user_default.png', id: :icon_prev_1, class: "user-icon-image", onClick: "$('.user_img').click()"
    end
  end

  # ヘッダー内のアイコン
  def user_header_icon
    if icon?
      image_tag icon.url, class: "user-icon-header"
    else
      image_tag 'https://img-photo.s3-ap-northeast-1.amazonaws.com/uploads/content_image/user_default.png', class: "user-icon-header"
    end
  end

  # チャット内のアイコン
  def chat_user_icon
    if icon?
      image_tag icon.url, id: "chat-icon"
    else
      image_tag 'https://img-photo.s3-ap-northeast-1.amazonaws.com/uploads/content_image/user_default.png', id: "chat-icon"
    end
  end
end
