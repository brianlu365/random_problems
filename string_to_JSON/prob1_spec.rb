require 'spec_helper'

describe 'parse_string_array(str)' do
  context "simple array" do
    subject(:res) {parse_string_array('[apple, orange]')}

    specify { expect(res).to eq ["apple","orange"] }
  end

  context "nested array" do
    subject(:res) {parse_string_array('[[apple,orange],[pc, mac]]')}

    specify { expect(res).to eq [["apple","orange"],["pc","mac"]]}
  end
end

describe 'convert_to_hash(str)' do
  subject(:res) {convert_to_hash("{key:[[value1, value2],[value3, value4]], 5:10:00AM]}")}

  specify { expect(res).to eq({"key" => [["value1", "value2"],["value3", "value4"]], 5=>"10:00AM"}) }
end

describe 'convert_to_json(str)' do
  subject(:res) {convert_to_json("{key:[[value1, value2],[value3, value4]], 5:10:00AM]}")}

  specify { expect(res).to eq "{\"key\":[[\"value1\",\"value2\"],[\"value3\",\"value4\"]],\"5\":\"10:00AM\"}" }
end