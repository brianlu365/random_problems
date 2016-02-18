#http://www.sitepoint.com/unraveling-string-key-performance-ruby-2-2/

require 'benchmark/ips'

STRING_HASH = { "foo" => "bar" }
SYMBOL_HASH = { :foo => "bar"  }
FIXNUM_HASH = { 123 => "bar" }
ARRAY_HASH = { [1,2,3] => "bar" }
Benchmark.ips do |x|
  x.report("string") { STRING_HASH["foo"] }
  x.report("symbol") { SYMBOL_HASH[:foo]  }
  x.report("fixnum") { FIXNUM_HASH[:foo]  }
  x.report("array") { ARRAY_HASH[:foo]  }
end