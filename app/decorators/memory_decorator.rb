# frozen_string_literal: true

module MemoryDecorator

  # new/editページ
  def image00_photo
    if image0.present? && add_image_id == 0
      image_tag image0.url, id: "img_prev_0", class: "photo-size"
    else
      image_tag "https://img-photo.s3-ap-northeast-1.amazonaws.com/uploads/content_image/NO_IMAGE.png", id: "img_prev_0", class: "photo-size"
    end
  end

  def image01_photo
    if image1.present? && add_image_id == 0
      image_tag image1.url, id: "img_prev_1", class: "photo-size"
    else
      image_tag "https://img-photo.s3-ap-northeast-1.amazonaws.com/uploads/content_image/NO_IMAGE.png", id: "img_prev_1", class: "photo-size"
    end
  end

  def image02_photo
    if image2.present? && add_image_id == 0
      image_tag image2.url, id: "img_prev_2", class: "photo-size"
    else
      image_tag "https://img-photo.s3-ap-northeast-1.amazonaws.com/uploads/content_image/NO_IMAGE.png", id: "img_prev_2", class: "photo-size"
    end
  end

  def image03_photo
    if image3.present? && add_image_id == 0
      image_tag image3.url, id: "img_prev_3", class: "photo-size"
    else
      image_tag "https://img-photo.s3-ap-northeast-1.amazonaws.com/uploads/content_image/NO_IMAGE.png", id: "img_prev_3", class: "photo-size"
    end
  end

  def image04_photo
    if image4.present? && add_image_id == 0
      image_tag image4.url, id: "img_prev_4", class: "photo-size"
    else
      image_tag "https://img-photo.s3-ap-northeast-1.amazonaws.com/uploads/content_image/NO_IMAGE.png", id: "img_prev_4", class: "photo-size"
    end
  end

  def image05_photo
    if image5.present? && add_image_id == 0
      image_tag image5.url, id: "img_prev_5", class: "photo-size"
    else
      image_tag "https://img-photo.s3-ap-northeast-1.amazonaws.com/uploads/content_image/NO_IMAGE.png", id: "img_prev_5", class: "photo-size"
    end
  end

  def image06_photo
    if image6.present? && add_image_id == 0
      image_tag image6.url, id: "img_prev_6", class: "photo-size"
    else
      image_tag "https://img-photo.s3-ap-northeast-1.amazonaws.com/uploads/content_image/NO_IMAGE.png", id: "img_prev_6", class: "photo-size"
    end
  end

  def image07_photo
    if image7.present? && add_image_id == 0
      image_tag image7.url, id: "img_prev_7", class: "photo-size"
    else
      image_tag "https://img-photo.s3-ap-northeast-1.amazonaws.com/uploads/content_image/NO_IMAGE.png", id: "img_prev_7", class: "photo-size"
    end
  end

  def memory_id
    if image0?
      image0.url.split("/")[4].to_i
    elsif image1?
      image1.url.split("/")[4].to_i
    elsif image2?
      image2.url.split("/")[4].to_i
    elsif image3?
      image3.url.split("/")[4].to_i
    elsif image4?
      image4.url.split("/")[4].to_i
    elsif image5?
      image5.url.split("/")[4].to_i
    elsif image6?
      image6.url.split("/")[4].to_i
    elsif image7?
      image7.url.split("/")[4].to_i
    end
  end

  def column
    if image0?
      image0.url.split("/")[3]
    elsif image1?
      image1.url.split("/")[3]
    elsif image2?
      image2.url.split("/")[3]
    elsif image3?
      image3.url.split("/")[3]
    elsif image4?
      image4.url.split("/")[3]
    elsif image5?
      image5.url.split("/")[3]
    elsif image6?
      image6.url.split("/")[3]
    elsif image7?
      image7.url.split("/")[3]
    end
  end

  def id_column
    if image0?
      image0.url.split("/")[4] + image0.url.split("/")[3]
    elsif image1?
      image1.url.split("/")[4] + image1.url.split("/")[3]
    elsif image2?
      image2.url.split("/")[4] + image2.url.split("/")[3]
    elsif image3?
      image3.url.split("/")[4] + image3.url.split("/")[3]
    elsif image4?
      image4.url.split("/")[4] + image4.url.split("/")[3]
    elsif image5?
      image5.url.split("/")[4] + image5.url.split("/")[3]
    elsif image6?
      image6.url.split("/")[4] + image6.url.split("/")[3]
    elsif image7?
      image7.url.split("/")[4] + image7.url.split("/")[3]
    end
  end

  def column_id
    if image0?
      image0.url.split("/")[3] + image0.url.split("/")[4]
    elsif image1?
      image1.url.split("/")[3] + image1.url.split("/")[4]
    elsif image2?
      image2.url.split("/")[3] + image2.url.split("/")[4]
    elsif image3?
      image3.url.split("/")[3] + image3.url.split("/")[4]
    elsif image4?
      image4.url.split("/")[3] + image4.url.split("/")[4]
    elsif image5?
      image5.url.split("/")[3] + image5.url.split("/")[4]
    elsif image6?
      image6.url.split("/")[3] + image6.url.split("/")[4]
    elsif image7?
      image7.url.split("/")[3] + image7.url.split("/")[4]
    end
  end

  def url
    if image0?
      image0.url.split("/")[5]
    elsif image1?
      image1.url.split("/")[5]
    elsif image2?
      image2.url.split("/")[5]
    elsif image3?
      image3.url.split("/")[5]
    elsif image4?
      image4.url.split("/")[5]
    elsif image5?
      image5.url.split("/")[5]
    elsif image6?
      image6.url.split("/")[5]
    elsif image7?
      image7.url.split("/")[5]
    end
  end

end
