require 'twitter'

class NewsService < Inflect::AbstractService
  # A WORDS Array constant with the key words of the Service.
  # @example Array for New York Times service
  #   words = %W[ NEWS TODAY NEW\ YORK\ TIMES]

  # In case there are modules that provide similar contents the
  # one with most PRIORITY is picked.
  # Float::Infinity is the lowest priority.
  def initialize
    @priority = 2
    @words    = %W[NOTICIAS]
    @twitter_id  = 91630276
    @title       = 'Tweets Diario Hoy'
  end

  attr_reader :twitter_id
  attr_reader :title

  # This is method is the only one needed for Inflect to work.
  # Implements how the service responds at the translated words.
  # Returns a Inflect::Response with retrieved data.
  def default
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = "0EOMlVsBuU0VNShIxBpoobxhk"
      config.consumer_secret     = "e2JDYCId5uucBtgsCV5epvu5GO7vjSVrnFI1Lj0Z3SkWK0KJrV"
      config.access_token        = "429379668-BgRseD5d6XHjZ3cZIE8KP21QCO3aqBp5sTsysXtr"
      config.access_token_secret = "SAJXh81CWxHM6N8WmYo6OgVdKjAoJSdBkFq7zGEjUlIM3"
    end

    timeline = client.user_timeline(twitter_id)
    tweets   = timeline.map { |tweet| tweet.text }
    content  = { title: 'Tweets del Diario Hoy', body: strip_urls(tweets) }

    respond content, { type: 'list' }
  end

  private

  # Strip a url from a collection of tweets
  # @param [Enumerable<String>] tweet
  # @return [Enumerable<String>]
  def strip_urls(tweets)
    tweets.map { |tweet| strip_url(tweet) }
  end

  # Strip a url from a tweet
  # @param [String] tweet
  # @return [String]
  def strip_url(tweet)
    regex = 'https://'
    current = tweet.rpartition(regex)

    while current.include? regex
      current = current.first.rpartition(regex)
    end
    current.last
  end
end
