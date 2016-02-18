require 'spec_helper'
require 'property'
require 'data_processor'
require 'csv'

describe Property do
  subject {Property.new(DataProcessor.new('cache.yaml').data.first)}

  describe '.new' do
    it 'should return have property info' do
      expect(subject.id).to eq 1
    end
  end

  describe '#avg_price' do
    it 'should return the average price' do
      expect(subject.avg_price).to eq 168.14
    end
  end

  describe '#booking_rate' do
    it 'should return the booking rate' do
      expect(subject.booking_rate).to eq 0.34
    end
  end
  
end