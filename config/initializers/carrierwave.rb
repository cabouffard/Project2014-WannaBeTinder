CarrierWave.configure do |config|
  config.fog_credentials = {
    provider:                "AWS",                        # required
    aws_access_key_id:       "X",         # required
    aws_secret_access_key:   "Y",         # required
    region:                  "us-east-1",                  # optional, defaults to "us-east-1"
    # host:                    "s3.example.com",             # optional, defaults to nil
    # endpoint:                "https://s3.example.com:8080" # optional, defaults to nil
  }
  # if Rails.env.production?
  #   config.fog_directory  = "#{ENV['S3_BUCKET']}/prd"   # required
  # else
  #   config.fog_directory  = "#{ENV['S3_BUCKET']}/dev"   # required
  # end
  #config.fog_public = false                             # optional, defaults to true
  # config.fog_attributes = { "Cache-Control" => "max-age=315576000" }  # optional, defaults to {}
end

