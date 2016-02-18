require_relative "cache"

class Factor
  def self.convert(ary)
    res = {}
    ary.size.times do
      head, *tails = ary
      res[head] = [] if res[head].nil?
      
      tails.each do |t|
        res[head] << t if head % t == 0

        res[t] = [] if res[t].nil?
        res[t] << head if t % head == 0
      end
      ary.shift
    end
    res
  end

  def self.cached_convert(ary)
    cache = Cache.new("cache.yaml")
    return cache.get(ary) if cache.get(ary)
    
    res = convert(ary)
    
    cache.set(ary, res)
    res
  end
end
