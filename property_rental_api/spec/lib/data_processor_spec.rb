require 'spec_helper'
require 'data_processor'

describe DataProcessor do
  subject {DataProcessor.new('cache.yaml')}
  after do
    subject.reset_cache # comment out to test caching
  end

  describe '.new' do
    it 'should read csv file' do
      expect(subject.data.first['zipcode']).to eq '94133'
    end
  end

  describe '#query' do
    it 'should return rows with zipcode 94133' do
      rows = subject.query {|r|
        r['zipcode'] == '94133'
      }
      expect(rows.size).to eq 144
    end

    it 'should return rows with zipcode 94133 and 2 bedrooms' do
      rows = subject.query {|r|
        r['zipcode'] == '94133' &&
        r['bedrooms'] == '2'
      }
      expect(rows.size).to eq 43
    end
  end

  describe '#estimate_price' do
    it "should return price for zipcode 94133 and 2 bedrooms" do
      expect(subject.estimate_price('94133', 2)).to eq 348.6
    end
  end

  describe '#estimate_booking_rate' do
    it "should return booking_rate for zipcode 94133" do
      expect(subject.estimate_booking_rate('94133')).to eq 0.54
    end
  end  

end