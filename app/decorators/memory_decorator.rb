# frozen_string_literal: true

module MemoryDecorator
  # new/editページ
  def image00_photo
    if image0.present? && add_image.zero?
      image_tag image0.url, id: "img_prev_0", class: "photo-size"
    else
      image_tag "https://img-photo.s3-ap-northeast-1.amazonaws.com/uploads/content_image/NO_IMAGE.png", id: "img_prev_0", class: "photo-size"
    end
  end

  def image01_photo
    if image1.present? && add_image.zero?
      image_tag image1.url, id: "img_prev_1", class: "photo-size"
    else
      image_tag "https://img-photo.s3-ap-northeast-1.amazonaws.com/uploads/content_image/NO_IMAGE.png", id: "img_prev_1", class: "photo-size"
    end
  end

  def image02_photo
    if image2.present? && add_image.zero?
      image_tag image2.url, id: "img_prev_2", class: "photo-size"
    else
      image_tag "https://img-photo.s3-ap-northeast-1.amazonaws.com/uploads/content_image/NO_IMAGE.png", id: "img_prev_2", class: "photo-size"
    end
  end

  def image03_photo
    if image3.present? && add_image.zero?
      image_tag image3.url, id: "img_prev_3", class: "photo-size"
    else
      image_tag "https://img-photo.s3-ap-northeast-1.amazonaws.com/uploads/content_image/NO_IMAGE.png", id: "img_prev_3", class: "photo-size"
    end
  end

  def image04_photo
    if image4.present? && add_image.zero?
      image_tag image4.url, id: "img_prev_4", class: "photo-size"
    else
      image_tag "https://img-photo.s3-ap-northeast-1.amazonaws.com/uploads/content_image/NO_IMAGE.png", id: "img_prev_4", class: "photo-size"
    end
  end

  def image05_photo
    if image5.present? && add_image.zero?
      image_tag image5.url, id: "img_prev_5", class: "photo-size"
    else
      image_tag "https://img-photo.s3-ap-northeast-1.amazonaws.com/uploads/content_image/NO_IMAGE.png", id: "img_prev_5", class: "photo-size"
    end
  end

  def image06_photo
    if image6.present? && add_image.zero?
      image_tag image6.url, id: "img_prev_6", class: "photo-size"
    else
      image_tag "https://img-photo.s3-ap-northeast-1.amazonaws.com/uploads/content_image/NO_IMAGE.png", id: "img_prev_6", class: "photo-size"
    end
  end

  def image07_photo
    if image7.present? && add_image.zero?
      image_tag image7.url, id: "img_prev_7", class: "photo-size"
    else
      image_tag "https://img-photo.s3-ap-northeast-1.amazonaws.com/uploads/content_image/NO_IMAGE.png", id: "img_prev_7", class: "photo-size"
    end
  end
end
