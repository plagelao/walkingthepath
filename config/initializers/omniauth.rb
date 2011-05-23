Rails.application.config.middleware.use OmniAuth::Builder do
  ENV['TWITTER_CONSUMER_KEY'] = 'KpXx3Q4OTEf8H3XITJy1Gw'
  ENV['TWITTER_CONSUMER_SECRET'] = 'UyEbYzK1PPdL9LVPyegmh9xdG2Bkq1wtjfpUAbOpEo'
  provider :twitter, ENV['TWITTER_CONSUMER_KEY'], ENV['TWITTER_CONSUMER_SECRET']
end
