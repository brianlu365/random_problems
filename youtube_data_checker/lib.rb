def check_file(name)
  if not name =~ /.*\.csv/
    abort 'bad file name. file name should end in .csv' 
  end

  begin 
    CSV.open(name, headers: true)
  rescue Exception => e
    abort e.message
  end
end

def youtube_id(url)
  res = url.reverse.match(/\A((?<id1>\w*)CU|(?<id2>\w*)).*\z/)
  id = res[:id1] || res[:id2]
  id.reverse
end

def sub_count(count)
  count.gsub(/\D/,'').to_i
end