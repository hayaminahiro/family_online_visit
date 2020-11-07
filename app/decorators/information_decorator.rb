# frozen_string_literal: true

module InformationDecorator
  def information_image(info)
    if info.image?
      image_tag info.image.url, id: :img_prev, :size => '500x500'
    else
      image_tag "https://img-photo.s3-ap-northeast-1.amazonaws.com/uploads/content_image/info.jpg", id: :img_prev, :size => '500x500'
    end
  end
end
