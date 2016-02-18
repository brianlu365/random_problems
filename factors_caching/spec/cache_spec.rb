require 'spec_helper'

describe Cache do
  subject {Cache.new('spec.yaml')}

  describe ".set" do
    it "should set cache" do
      expect(subject.set([10,5,2,20],{10=>[5, 2], 5=>[], 2=>[], 20=> [10, 5, 2]})).to eq true
      expect(subject.get([10,5,2,20])).to eq({10=>[5, 2], 5=>[], 2=>[], 20=> [10, 5, 2]})
    end
  end
end
