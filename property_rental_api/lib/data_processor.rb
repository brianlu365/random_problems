require 'csv'
require 'yaml'
require 'property'
require 'linear_regression'

class DataProcessor
  attr_reader :data

  def initialize(cache_file_name)
    @data = CSV.open(__dir__+'/data_for_challenge.csv', headers: true)
    @file = File.open(__dir__+"/#{cache_file_name}", 'a+')
    @cached_res = YAML::load(@file.read) || {}
  end

  def query(&block)
    data = @data.each
    data.select do |row|
      block.call row
    end
  end

  def estimate_price(zipcode, bedroom_count)
    res = get_or_set_cache(zipcode)

    return nil if res.nil?

    (res[:price_slope] * bedroom_count + res[:price_y_intercept]).round(2)
  end

  def estimate_booking_rate(zipcode)
    res = get_or_set_cache(zipcode)
    
    return nil if res.nil?

    res[:avg_booking_rate]    
  end

  def get_or_set_cache(zipcode)
    if @cached_res[zipcode]
      puts "hit!"
      return @cached_res[zipcode]
    else
      puts "miss!"
      properties = query{|r| r['zipcode'] == zipcode}
      return nil if properties.empty?

      properties.map!{|r| Property.new r}

      ary = []
      # find slope and y_intercept
      properties.each do |p|
        ary << [p.avg_price, p.bedroom_count] if p.avg_price and p.bedroom_count > 0
      end
      price_ary, bdrm_ary = ary.transpose

      lin_reg = LinearRegression.new(bdrm_ary, price_ary)

      # average booking rate
      booking_rate_ary = properties.map{|p| p.booking_rate}.select{|p| not p.nil?}
      avg_booking_rate = (booking_rate_ary.reduce(:+) / booking_rate_ary.size).round(2)

      # save to cache
      @cached_res[zipcode] = {price_slope: lin_reg.slope, price_y_intercept: lin_reg.y_intercept, avg_booking_rate: avg_booking_rate}
      @file.truncate(0)
      @file.write(YAML::dump(@cached_res))
      @cached_res[zipcode]
    end
  end

  def reset_cache
    @file.truncate(0)
  end
end