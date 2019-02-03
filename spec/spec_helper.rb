require './lib/feedcon'
require './env_variable'
describe Feedcon do
  context 'RSS feed' do
    feed = Feedcon.new('https://www.nasa.gov/rss/dyn/educationnews.rss')

    it 'output is Array' do
      expect(feed.convert_feed).to be_an_instance_of(Array)
    end

    it 'output element is Hash' do
      expect(feed.convert_feed[0]).to be_an_instance_of(Hash)
    end

    it 'element Hash contain keys' do
      expect(feed.convert_feed[0]).to include(:title, :text, :link, :date)
    end
  end

  context 'VK feed' do
    feed1 = Feedcon.new('https://vk.com/public63589724')
    feed2 = Feedcon.new('https://vk.com/bitnovosticom')

    it 'id and domain output the same' do
      expect(feed1.convert_feed).to eq(feed2.convert_feed)
    end

    it 'right request result' do
      expect(feed2.create_api_request).to include('api.vk.com')
    end

    it 'output is Array' do
      expect(feed2.convert_feed).to be_an_instance_of(Array)
    end

    it 'output element is Hash' do
      expect(feed2.convert_feed[0]).to be_an_instance_of(Hash)
    end

    it 'element Hash contain keys' do
      expect(feed2.convert_feed[0]).to include(:text, :link, :date)
    end
  end
end
