require 'spec_helper'

describe Factor do  
  describe ".convert" do
    specify "[10] returns {10: []}"  do 
      expect(Factor.convert([10])).to eq({10=>[]})
    end

    specify "[10, 5] returns {10: [5], 5: []}" do
      expect(Factor.convert([10, 5])).to eq({10=>[5], 5=>[]})
    end

    specify "[10, 5, 2] returns {10: [5, 2], 5: [], 2: []}" do
      expect(Factor.convert([10,5, 2])).to eq({10=>[5, 2], 5=>[], 2=>[]})
    end

    specify "[10, 5, 2, 20] returns {10: [5, 2], 5: [], 2: [], 20: [10, 5, 2]}" do
      expect(Factor.convert([10, 5, 2, 20])).to eq({10=>[5, 2], 5=>[], 2=>[], 20=> [10, 5, 2]})
    end
  end

  describe ".cached_concert" do
    specify "[10, 5, 2, 20] returns {10: [5, 2], 5: [], 2: [], 20: [10, 5, 2]}" do
      expect(Factor.cached_convert([10, 5, 2, 20])).to eq({10=>[5, 2], 5=>[], 2=>[], 20=> [10, 5, 2]})
    end
  end
end
