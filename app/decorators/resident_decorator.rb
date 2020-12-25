# frozen_string_literal: true

module ResidentDecorator
  def modal_title
    id.present? ? "入居者情報編集" : "入居者新規登録"
  end

  def image_columns
    image_columns = []
    memories.each do |m|
      image_columns << m.image0 if m.image0?
      image_columns << m.image1 if m.image1?
      image_columns << m.image2 if m.image2?
      image_columns << m.image3 if m.image3?
      image_columns << m.image4 if m.image4?
      image_columns << m.image5 if m.image5?
      image_columns << m.image6 if m.image6?
      image_columns << m.image7 if m.image7?
    end
    image_columns
  end
end
