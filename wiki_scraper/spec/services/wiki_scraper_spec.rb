require 'rails_helper'

describe WikiScraper, vcr: true do
  describe '#get_event_urls_on' do
    let(:date) {Date.parse('1/1/2010')}
    it 'should return event urls' do
      urls = WikiScraper.new.get_event_urls_on(date)
      expect(urls.size).to eq 10
      expect(urls.first).to eq 'https://en.wikipedia.org/wiki/Revolutionary_Armed_Forces_of_Colombia'
    end
  end

  describe '#perform' do
    it 'should add jobs for event scraper' do
      expect(WikiScraper.new.perform('1/1/2010').size).to eq 10
    end
  end
end