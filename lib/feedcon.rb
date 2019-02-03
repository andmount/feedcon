# Convert RSS or VK.com feed to array of elements (hashes)
class Feedcon
  require 'rss'
  require 'open-uri'
  require 'json'
  require 'net/http'
  attr_accessor :url
  def initialize(url)
    @url = url
  end

  def convert_rss
    elements_array = []
    rss = RSS::Parser.parse(URI.parse(@url).open)
    rss.items.each do |item|
      element_hash = {
        title: item.title,
        description: item.description,
        link: item.link,
        date: item.pubDate
      }
      elements_array << element_hash
    end
    elements_array
  end

  def create_api_request
    request_api_token_part = "https://api.vk.com/method/wall.get?v=5.52&access_token=#{ENV['vk_token']}"
    if @url[/club\d+/].nil? && @url[/public\d+/].nil? && @url[/id\d+/].nil?
      page_name = @url[15..-1]
      request_api_full = request_api_token_part + "&domain=#{page_name}&filter=owner"
    else
      page_id = (@url[/id\d*/].nil?) ? "-#{@url[/\d+/]}" : @url[/\d+/]
      request_api_full = request_api_token_part + "&owner_id=#{page_id}&filter=owner"
    end
    request_api_full
  end

  def convert_vk
    elements_array = []
    json = JSON.parse(Net::HTTP.get(URI.parse(create_api_request)))
    json['response']['items'].each do |item|
      element_hash = {
        text: item['text'],
        link: "https://vk.com/wall#{item['owner_id']}_#{item['id']}",
        date: Time.at(item['date'])
      }
      elements_array << element_hash
    end
    elements_array
  end

  def convert_feed
    @url.include?('vk.com') ? self.convert_vk : self.convert_rss
  end
end
