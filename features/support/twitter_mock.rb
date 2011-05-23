module Twitter
  def self.update(tweet)
    @@last_update = tweet
  end

  def self.last_update
    @@last_update
  end
end
