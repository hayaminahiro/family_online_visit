# frozen_string_literal: true

module MemoryDecorator

  # indexページ
  def image00
    image_tag image0.url, class: "img-interval index-photo-size" if image0?
  end

  def image01
    image_tag image1.url, class: "img-interval index-photo-size" if image1?
  end

  def image02
    image_tag image2.url, class: "img-interval index-photo-size" if image2?
  end

  def image03
    image_tag image3.url, class: "img-interval index-photo-size" if image3?
  end

  def image04
    image_tag image4.url, class: "img-interval index-photo-size" if image4?
  end

  def image05
    image_tag image5.url, class: "img-interval index-photo-size" if image5?
  end

  def image06
    image_tag image6.url, class: "img-interval index-photo-size" if image6?
  end

  def image07
    image_tag image7.url, class: "img-interval index-photo-size" if image7?
  end

  def card_image
    image_tag image0.url, class: "card-photo-size" if image0.present?
  end

  # showページ
  def image00_s
    image_tag image0.url, class: "img-interval show-photo-size" if image0?
  end

  def image01_s
    image_tag image1.url, class: "img-interval show-photo-size" if image1?
  end

  def image02_s
    image_tag image2.url, class: "img-interval show-photo-size" if image2?
  end

  def image03_s
    image_tag image3.url, class: "img-interval show-photo-size" if image3?
  end

  def image04_s
    image_tag image4.url, class: "img-interval show-photo-size" if image4?
  end

  def image05_s
    image_tag image5.url, class: "img-interval show-photo-size" if image5?
  end

  def image06_s
    image_tag image6.url, class: "img-interval show-photo-size" if image6?
  end

  def image07_s
    image_tag image7.url, class: "img-interval show-photo-size" if image7?
  end

  # new/editページ
  def image00_photo
    if image0.present?
      image_tag image0.url, id: "img_prev_0", class: "photo-size"
    else
      image_tag "https://img-photo.s3-ap-northeast-1.amazonaws.com/uploads/content_image/NO_IMAGE.png", id: "img_prev_0", class: "photo-size"
    end
  end

  def image01_photo
    if image1.present?
      image_tag image1.url, id: "img_prev_1", class: "photo-size"
    else
      image_tag "https://img-photo.s3-ap-northeast-1.amazonaws.com/uploads/content_image/NO_IMAGE.png", id: "img_prev_1", class: "photo-size"
    end
  end

  def image02_photo
    if image2.present?
      image_tag image2.url, id: "img_prev_2", class: "photo-size"
    else
      image_tag "https://img-photo.s3-ap-northeast-1.amazonaws.com/uploads/content_image/NO_IMAGE.png", id: "img_prev_2", class: "photo-size"
    end
  end

  def image03_photo
    if image3.present?
      image_tag image3.url, id: "img_prev_3", class: "photo-size"
    else
      image_tag "https://img-photo.s3-ap-northeast-1.amazonaws.com/uploads/content_image/NO_IMAGE.png", id: "img_prev_3", class: "photo-size"
    end
  end

  def image04_photo
    if image4.present?
      image_tag image4.url, id: "img_prev_4", class: "photo-size"
    else
      image_tag "https://img-photo.s3-ap-northeast-1.amazonaws.com/uploads/content_image/NO_IMAGE.png", id: "img_prev_4", class: "photo-size"
    end
  end

  def image05_photo
    if image5.present?
      image_tag image5.url, id: "img_prev_5", class: "photo-size"
    else
      image_tag "https://img-photo.s3-ap-northeast-1.amazonaws.com/uploads/content_image/NO_IMAGE.png", id: "img_prev_5", class: "photo-size"
    end
  end

  def image06_photo
    if image6.present?
      image_tag image6.url, id: "img_prev_6", class: "photo-size"
    else
      image_tag "https://img-photo.s3-ap-northeast-1.amazonaws.com/uploads/content_image/NO_IMAGE.png", id: "img_prev_6", class: "photo-size"
    end
  end

  def image07_photo
    if image7.present?
      image_tag image7.url, id: "img_prev_7", class: "photo-size"
    else
      image_tag "https://img-photo.s3-ap-northeast-1.amazonaws.com/uploads/content_image/NO_IMAGE.png", id: "img_prev_7", class: "photo-size"
    end
  end

end
