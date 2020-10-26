module InformationsHelper
  def information_image(info)
    if info.image?
      image_tag info.image.url, id: :img_prev, :size => '500x500'
    else
      image_tag "https://img-photo.s3-ap-northeast-1.amazonaws.com/uploads/content_image/info.jpg", id: :img_prev, :size => '500x500'
    end
  end

  # facility_idごとにグループ分けする
  def grouped_facility(information)
    information.group_by(&:facility_id)
  end

  # 施設のiconを表示
  def mypage_informations_icon(id)
    facility = Facility.find(id)
    return image_tag facility.icon.url, class: "mypage-info-icon-image" if facility.icon?
    image_tag 'https://img-photo.s3-ap-northeast-1.amazonaws.com/uploads/content_image/facility_default.png', class: "mypage-info-icon-image"
  end

  # 自分が登録している施設のお知らせで、statusがothersであるものを全て取得する
  def mypage_informations(id)
    Information.where(facility_id: id).where(status: "others")
  end
end
