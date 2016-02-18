require 'spec_helper'

describe HashParser do
  subject(:hp) {HashParser.new({"this" => [1,2,3,4,5,6], "that" => ['here', 'there', 'everywhere'], :other => 'here'})}

  specify { expect(hp.this).to eq [1,2,3,4,5,6] }
  specify { expect(hp.that).to eq ['here', 'there', 'everywhere'] }
  specify { expect(hp.other).to eq 'here' }
end