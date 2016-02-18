class Transaction < ActiveRecord::Base
  validates_presence_of :day_number, :change_amount, :transaction_type
  validates :day_number, numericality: { greater_than: 0, only_integer: true }

  # assume withdraw and payment are made at the begining of the day.
  # principal and interest are calculated at the end of the day.

  def self.principal_on_day(num)
    where("day_number <= #{num}").sum(:change_amount)
  end

  def self.interest_on_day(num, apr_percent)
    adjusted_num = num - num % 30 + 1
    
    apr = apr_percent.to_f / 100
    transactions = where("day_number <= #{adjusted_num}").order(day_number: :desc)
    temp = []
    transactions.each_with_index {|t, i|
      if i == 0
        previous_day_number = adjusted_num
        duration = previous_day_number - t.day_number - 1
      elsif i == transactions.size - 1
        previous_day_number = transactions[i-1].day_number
        duration = previous_day_number - t.day_number + 1
      else
        previous_day_number = transactions[i-1].day_number
        duration = previous_day_number - t.day_number 
      end

      temp << transactions.where("day_number < #{previous_day_number}").sum(:change_amount) * duration
    }

    (apr / 365 * (temp.reduce(:+) || 0)).round(2)
  end

  def self.balance_on_day(num, apr_percent)
    principal_on_day(num) + interest_on_day(num, apr_percent)
  end

  def self.next_closing_day
    if all.size == 0
      30
    else
      ((order(:day_number).last.day_number / 30) + 1) * 30
    end
  end
end
