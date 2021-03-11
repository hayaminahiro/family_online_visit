require 'carrierwave/storage/abstract'
require 'carrierwave/storage/file'
require 'carrierwave/storage/fog'

# AWS
CarrierWave.configure do |config|
  if Rails.env.production? # 本番環境:AWS使用
    config.storage :fog
    config.fog_provider = 'fog/aws'
    config.fog_directory = Rails.application.credentials.aws[:bucket]
    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: Rails.application.credentials.aws[:access_key_id],
      aws_secret_access_key: Rails.application.credentials.aws[:secret_access_key],
      region: Rails.application.credentials.aws[:region],
      path_style: true
    }
    config.fog_attributes = { cache_control: "public, max-age=#{365.days.to_i}" }
  else
    config.storage :file # 開発環境:public/uploades下に保存
    config.enable_processing = false if Rails.env.test? #test:処理をスキップ
  end
end

# heroku
# CarrierWave.configure do |config|
#   config.storage :fog
#   config.fog_provider = 'fog/aws'
#   config.fog_directory = ENV['AWS_S3_BUCKET']
#   config.fog_credentials = {
#     provider: 'AWS',
#     aws_access_key_id: ENV['AWS_ACCESS_KEY_ID'],
#     aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
#     region: 'ap-northeast-1',
#     path_style: true
#   }
#   config.fog_attributes = { cache_control: "public, max-age=#{365.days.to_i}" }
# end
