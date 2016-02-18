class Property
  attr_reader :id, :bedroom_count, :zipcode, :accomodates
  
  def initialize(row)
    @id = row['property_id'].to_i
    @zipcode = row['zipcode']
    @bedroom_count = row['bedrooms'].to_i
    @accomodates = row['accomodates'].to_i
    @row = row
  end

  def booking_rate
    ary = @row.to_a[4..-1].reject {|a| a.last == 'unavailable'}
    reserved_count = ary.count {|a| a.last == 'reserved'}
    (reserved_count.to_f / ary.size).round(2) if ary.size > 0
  end

  def avg_price
    prices = @row.to_a[4..-1].map{|p| p.last.to_i}
                             .select {|p| p > 0}
    (prices.reduce(:+).to_f / prices.size).round(2) if prices.size > 0
  end
end