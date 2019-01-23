# Convert RSS or Twitter feed in array of elements
class Feedcon
  require 'rubygems'
  require 'rss'
  require 'open-uri'
  require 'json'
  require 'twitter'
  def initialize(url)
    @url = url
  end

  def convert_rss
    elements_array = []
    rss = RSS::Parser.parse(URI.parse(@url).open)
    rss.items.each do |item|
      element_hash = {
        title: item.title, description: item.description,
        link: item.link, date: item.pubDate
      }
      elements_array << element_hash
    end
    elements_array
  end

  def convert_tweet; end
end
