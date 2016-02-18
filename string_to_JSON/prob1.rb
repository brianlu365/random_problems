#Convert this string string = "{key:[[value1, value2],[value3, value4]], 5:10:00AM]}" 
#to this hash: h = {"key" => [["value1", "value2"],["value3", "value4"]], 5=>"10:00AM"} 
#then convert h to JSON. Please note that the brackets are unbalanced on purpose.   
require 'json'


def parse_string_array(str)
  JSON.parse(str.gsub(/\w+/){|s| "\"#{s}\""})
end

def convert_to_hash(str)
  res = str.match /(?<k1>\w+):(?<v1>\[.*\]), (?<k2>\d+):(?<v2>\d{2}:\d{2}(AM|PM))/

  {res[:k1] => parse_string_array(res[:v1]), res[:k2].to_i => res[:v2]}
end

def convert_to_json(str)
  convert_to_hash(str).to_json
end