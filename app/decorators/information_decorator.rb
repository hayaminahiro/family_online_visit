# frozen_string_literal: true

module InformationDecorator
  def information_image
    if image?
      image_tag image.url, id: :img_prev, size: '500x500'
    else
      image_tag "https://img-photo.s3-ap-northeast-1.amazonaws.com/uploads/content_image/info.jpg", id: :img_prev, size: '500x500'
    end
  end

  def info_mobile_image
    if image?
      image_tag image.url, id: :img_prev_1, class: "info-mobile-image", onClick: "$('.image_uploading').click()"
    else
      image_tag "https://img-photo.s3-ap-northeast-1.amazonaws.com/uploads/content_image/info.jpg", id: :img_prev_1, class: "info-mobile-image", onClick: "$('.image_uploading').click()"
    end
  end
end
