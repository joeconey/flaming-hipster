if Rails.env.production?
  CarrierWave.configure do |config|
    config.fog_credentials = {
      # Configuration for Amazon S3
      :provider              => 'AWS',
      :aws_access_key_id     => ENV['AKIAJWKWZPSB3DHKGI5A'],
      :aws_secret_access_key => ENV['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']
    }
    config.fog_directory     =  ENV['ideas-test1']
  end
end