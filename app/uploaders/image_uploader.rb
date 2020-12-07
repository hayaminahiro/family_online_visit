class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  if Rails.env.production?
    storage :fog # 本番環境のみ
  else
    storage :file # 本番環境以外
  end

  # 開発環境も本番環境もS3に保存(お試し用)
  # storage :fog

  def store_dir
    if model.present?
      "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    else
      'uploads/content_image/'
    end
  end

  def extension_whitelist
    %w[jpg jpeg gif png]
  end

  # デフォルト画像は1200x5000に収まるようリサイズ
  process resize_to_limit: [1200, 5000]

  # サムネイル画像/使い方の例 <%= image_tag @facility.image.url(:thumb) %>
  # サイズが大きいとエラーになる上、画質も落ちるので今回は未使用（size=>で直接指定）
  # version :thumb do
  #   process resize_to_fit: [100, 100]
  # end

  def filename
    original_filename if original_filename
    # original_filenameのみの記述で問題なければ修正
  end
end
