require 'carrierwave/storage/abstract'
require 'carrierwave/storage/file'
require 'carrierwave/storage/fog'

# AWS
CarrierWave.configure do |config|
  config.storage :fog
  config.fog_provider = 'fog-aws'
  config.fog_directory = Rails.application.credentials.aws[:bucket]
  config.fog_credentials = {
    provider: 'AWS',
    aws_access_key_id: Rails.application.credentials.aws[:access_key_id],
    aws_secret_access_key: Rails.application.credentials.aws[:secret_access_key],
    region: Rails.application.credentials.aws[:region],
    path_style: true
  }
  config.fog_attributes = { cache_control: "public, max-age=#{365.days.to_i}" }
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
