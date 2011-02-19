Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, ENV['TWITTER_CONSUMER_KEY'], ENV['CONSUMER_SECRET']
end
