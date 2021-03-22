class Information < ApplicationRecord
  belongs_to :facility

  validates :news, presence: true
  validates :title, presence: true

  enum status: { others: 0, admin: 1 }

  # モデル | ImageUploaderクラスとimageカラムを紐づける
  mount_uploader :image, ImageUploader

  scope :set_limit, -> { order(id: "DESC").limit(15) }
  scope :admin_list, -> { where(status: "admin").set_limit }
  scope :facility_list, -> (facility) { where(facility_id: facility).set_limit }


  # search定義
  def self.search(search, facility)
    facility.informations.where(status: "others").order(id: "DESC") unless search
    facility.informations.where(status: "others").where('title LIKE ?', "%#{search}%").order(id: "DESC")
  end

  def update_with_url(information_params)
    information_params[:url] = information_params[:url].last(11)
    update(information_params)
  end
end
