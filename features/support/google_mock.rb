module Googl
  def self.shorten(url)
    Googl::Url.new(url)
  end
  class Url
    attr_reader :short_url
    def initialize(url)
      @short_url = url
    end
  end
end
