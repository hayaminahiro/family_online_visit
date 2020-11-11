# frozen_string_literal: true

module MemoryDecorator

  # def link
  #   link_to full_name, website
  # end

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

end
