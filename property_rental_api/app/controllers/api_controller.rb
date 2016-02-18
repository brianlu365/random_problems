class ApiController < ApplicationController
  before_action :initialize_data_processor

  def price
    price = @dp.estimate_price(params[:zipcode].to_s, params[:bedroom_count].to_i)

    error_helper(price) {
      render json: {price: price}, status: 200
    }
  end

  def booking_rate
    rate = @dp.estimate_booking_rate(params[:zipcode].to_s)

    error_helper(rate) {
      render json: {booking_rate: rate}
    }
  end

  def earnings
    price = @dp.estimate_price(params[:zipcode].to_s, params[:bedroom_count].to_i)
    rate = @dp.estimate_booking_rate(params[:zipcode].to_s)

    # including the end day
    duration = (params[:end_date].to_date - params[:start_date].to_date).to_i + 1

    error_helper(price, rate, duration) {
      render json: {earnings: (price * duration * rate).round(2)}
    }

  end

  private
  
  def initialize_data_processor
    @dp = DataProcessor.new('cache.yaml')
  end

  def error_helper(*value)
    if value.include? nil
      render json: {error: "not found"}, status: 404
    else
      yield
    end
  end
end
