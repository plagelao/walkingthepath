Twitter.configure do |config|
  config.consumer_key = ENV['TWITTER_ALERT_CK']
  config.consumer_secret = ENV['TWITTER_ALERT_CS']
  config.oauth_token = ENV['TWITTER_ALERT_OT']
  config.oauth_token_secret = ENV['TWITTER_ALERT_OTS']
end
