require 'yaml'

class Cache
  attr_accessor :cached_res, :file

  def initialize(file_name)
    @file = File.open("#{__dir__}/#{file_name}", 'w+')
    @cached_res = YAML::load(@file.read) || {}
  end

  def set(ary,res)
    sorted_ary = ary.sort {|x,y| x <=> y}
    @cached_res[sorted_ary.hash] = res if @cached_res[sorted_ary.hash].nil?
    if @file.write(YAML::dump(@cached_res))
      true
    else
      raise "set failed"
    end
  end

  def get(ary)
    sorted_ary = ary.sort {|x,y| x <=> y}
    @cached_res[sorted_ary.hash]
  end
end