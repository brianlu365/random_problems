#!/usr/bin/env ruby

require 'csv'
require_relative 'lib'


file_name_1, file_name_2, concern = ARGV

unless file_name_1 and file_name_2
  abort 'please supply two file name. e.g. yt_data_checker [file1.csv] [file2.csv] [concern].'
end

unless [nil, 'subscriber_count', 'channel_ownership'].include? concern
  abort 'bad concern option. you can leave it empty or use subscriber_count or channel_ownership.'
end

file1 = check_file file_name_1
file2 = check_file file_name_2

file1.zip(file2).each do |r1, r2|
  email = r1['Account Email'].strip

  youtube_diff = (youtube_id(r1['YouTube Channel']) != youtube_id(r2['YouTube Channel'])) 
  count_diff = (sub_count(r1['Subscriber Count']) != sub_count(r2['Subscriber Count'])) 

  case concern
  when 'channel_ownership'
    puts email if youtube_diff
  when 'subscriber_count'
    puts email if count_diff
  else
    puts email if youtube_diff || count_diff
  end    
end


