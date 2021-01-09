# frozen_string_literal: true

module FacilityDecorator
  def facility_season_image
    if image?
      image_tag image.url, id: :img_prev, size: '500x500'
    else
      month = Time.zone.today.month
      if month.in?([12, 1, 2])
        image_tag 'https://img-photo.s3-ap-northeast-1.amazonaws.com/uploads/content_image/winter.jpg', id: :img_prev, size: '500x500'
      elsif month.in?([3, 4, 5])
        image_tag 'https://img-photo.s3-ap-northeast-1.amazonaws.com/uploads/content_image/spring.jpg', id: :img_prev, size: '500x500'
      elsif month.in?([6, 7, 8])
        image_tag 'https://img-photo.s3-ap-northeast-1.amazonaws.com/uploads/content_image/summer.jpg', id: :img_prev, size: '500x500'
      elsif month.in?([9, 10, 11])
        image_tag 'https://img-photo.s3-ap-northeast-1.amazonaws.com/uploads/content_image/+autumn.jpg', id: :img_prev, size: '500x500'
      end
    end
  end

  # 施設ログイン時の背景画像の表示
  def facility_background_image
    if image?
      image_tag image.url, class: "home-image"
    else
      month = Time.zone.today.month
      if month.in?([12, 1, 2])
        image_tag 'https://img-photo.s3-ap-northeast-1.amazonaws.com/uploads/content_image/winter.jpg', class: "home-image"
      elsif month.in?([3, 4, 5])
        image_tag 'https://img-photo.s3-ap-northeast-1.amazonaws.com/uploads/content_image/spring.jpg', class: "home-image"
      elsif month.in?([6, 7, 8])
        image_tag 'https://img-photo.s3-ap-northeast-1.amazonaws.com/uploads/content_image/summer.jpg', class: "home-image"
      elsif month.in?([9, 10, 11])
        image_tag 'https://img-photo.s3-ap-northeast-1.amazonaws.com/uploads/content_image/+autumn.jpg', class: "home-image"
      end
    end
  end

  # 施設編集（モバイル）背景画像
  def facility_edit_background_image
    if image?
      image_tag image.url, id: :mobile_prev, class: "home-image", onClick: "$('.image_uploading').click()"
    else
      month = Time.zone.today.month
      if month.in?([12, 1, 2])
        image_tag 'https://img-photo.s3-ap-northeast-1.amazonaws.com/uploads/content_image/winter.jpg', id: :mobile_prev, class: "home-image", onClick: "$('.image_uploading').click()"
      elsif month.in?([3, 4, 5])
        image_tag 'https://img-photo.s3-ap-northeast-1.amazonaws.com/uploads/content_image/spring.jpg', id: :mobile_prev, class: "home-image", onClick: "$('.image_uploading).click()"
      elsif month.in?([6, 7, 8])
        image_tag 'https://img-photo.s3-ap-northeast-1.amazonaws.com/uploads/content_image/summer.jpg', id: :mobile_prev, class: "home-image", onClick: "$('.image_uploading').click()"
      elsif month.in?([9, 10, 11])
        image_tag 'https://img-photo.s3-ap-northeast-1.amazonaws.com/uploads/content_image/+autumn.jpg', id: :mobile_prev, class: "home-image", onClick: "$('.image_uploading').click()"
      end
    end
  end

  def facility_icon_image
    if icon?
      image_tag icon.url, id: :icon_prev, class: "icon_circle"
    else
      image_tag 'https://img-photo.s3-ap-northeast-1.amazonaws.com/uploads/content_image/facility_default.png', id: :icon_prev, class: "icon_circle"
    end
  end

  # チャット内のアイコン
  def chat_facility_icon
    if icon?
      image_tag icon.url, id: "chat-icon"
    else
      image_tag 'https://img-photo.s3-ap-northeast-1.amazonaws.com/uploads/content_image/facility_default.png', id: "chat-icon"
    end
  end

  # 施設のモバイルでのアイコン表示
  def facility_icon_responsive
    if icon?
      image_tag icon.url, class: "user-icon-image"
    else
      image_tag 'https://img-photo.s3-ap-northeast-1.amazonaws.com/uploads/content_image/facility_default.png', class: "default-icon-image"
    end
  end

  # 施設のモバイルでのアイコン編集
  def facility_icon_edit_responsive
    if icon?
      image_tag icon.url, id: :mobile2_prev, class: "user-icon-image", onClick: "$('.image_uploading_icon').click()"
    else
      image_tag 'https://img-photo.s3-ap-northeast-1.amazonaws.com/uploads/content_image/facility_default.png', id: :mobile2_prev, class: "default-icon-image", onClick: "$('.image_uploading_icon').click()"
    end
  end

  def reservation_calendar
    Reservation.where.not(calendar_day: nil)
  end

  def request_count(requests)
    requests.present? ? tag.sup(requests.count) : nil
  end

  def acceptance_requests(user)
    RequestResident.includes(:user).where(user_id: user).where(facility_id: id).where(req_approval: "request")
  end

  def newly_numbers(r_ids)
    r_ids[:resident_ids].map(&:to_i).reject(&:zero?)
  end

  def resident_name(resident_id)
    resident = Resident.find(resident_id)
    resident.name if resident.facility_id == id
  end
end
