require 'rails_helper'

describe EventScraper, vcr: true do
  describe '#get_event_detail' do
    before do
      EventScraper.new.perform('2010-01-01', 'https://en.wikipedia.org/wiki/Revolutionary_Armed_Forces_of_Colombia')
    end
    it 'should save detail to db' do
      expect(Event.first.title).to eq "FARC"
    end
  end
end