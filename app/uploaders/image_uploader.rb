class ImageUploader < CarrierWave::Uploader::Base
  # 開発環境はローカル/本番環境はS3に保存
  # if Rails.env.development?
  #   storage :file
  # elsif Rails.env.test?
  #   storage :file
  # else
  #   storage :fog
  # end

  # 開発環境も本番環境もS3に保存
  storage :fog

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_whitelist
    %w(png jpg)
  end

  def filename
    original_filename if original_filename
  end
end
