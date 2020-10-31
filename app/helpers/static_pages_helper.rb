module StaticPagesHelper

  def facility_season_image(facility)
    if facility.image?
      image_tag facility.image.url, id: :img_prev, :size => '500x500'
    else
      month = Date.today.month
      if month.in?([ 12, 1, 2 ])
        image_tag 'https://img-photo.s3-ap-northeast-1.amazonaws.com/uploads/content_image/winter.jpg', id: :img_prev, :size => '500x500'
      elsif month.in?([ 3, 4, 5 ])
        image_tag 'https://img-photo.s3-ap-northeast-1.amazonaws.com/uploads/content_image/spring.jpg', id: :img_prev, :size => '500x500'
      elsif month.in?([ 6, 7, 8 ])
        image_tag 'https://img-photo.s3-ap-northeast-1.amazonaws.com/uploads/content_image/summer.jpg', id: :img_prev, :size => '500x500'
      elsif month.in?([ 9, 10, 11 ])
        image_tag 'https://img-photo.s3-ap-northeast-1.amazonaws.com/uploads/content_image/+autumn.jpg', id: :img_prev, :size => '500x500'
      end
    end
  end
end
