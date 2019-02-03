# Feedcon is a handy way to convert feeds of RSS and VK
## Usage
1. Add vk.com access token to an environmental variable in your code
```ruby
ENV['vk_token'] = 'YOUR_TOKEN'
```
2. Create instanse of `Feedcon` class and use methods
```ruby
feed = Feedcon.new('RSS_LINK_OR_PAGE_VK')

feed.convert_feed # take RSS or VK page => array of elements
feed.convert_rss # take only RSS => array of elements
feed.convert_vk # take only VK page => array of elements
feed.create_api_request # => api request string
```
3. You can freely change `url` of the object for your needs
```ruby
feed = Feedcon.new('https://vk.com/example1')
puts feed.url
# => 'https://vk.com/example1'
puts feed.url = 'https://vk.com/example2'
# => 'https://vk.com/example2'
```
## Output
*For RSS:* `[ {title: string, description: string, link: string, date: Time object}, {...}, {...} ]`

*For VK:* `[ {text: string, link: string, date: Time object}, {...}, {...} ]`