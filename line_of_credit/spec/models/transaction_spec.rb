require 'rails_helper'

RSpec.describe Transaction, type: :model do
  subject {described_class}
  before do
    create :transaction, day_number: 1, change_amount: 500, transaction_type: 'withdraw'
    create :transaction, day_number: 15, change_amount: -200, transaction_type: 'payment'
    create :transaction, day_number: 25, change_amount: 100, transaction_type: 'withdraw'
  end
  
  describe ".principal_on_day(num)" do
    it "should return 500 on day 14" do
      expect(subject.principal_on_day(14)).to eq 500.0
    end

    it "should return 300 on day 15" do
      expect(subject.principal_on_day(15)).to eq 300.0
    end

    it "should return 400 on day 30" do
      expect(subject.principal_on_day(30)). to eq 400.0
    end
  end

  describe ".interest_on_day(num, apr_percent)" do
    context "interest will not be charged until the closing of a 30 day payment period" do
      it "should return 0 on day 29" do
        expect(subject.interest_on_day(29, 35)).to eq 0.0
      end

      it "should return 11.99 on day 30" do
        expect(subject.interest_on_day(30, 35)).to eq 11.99
      end

      it "should return 11.99 on day 59" do
        expect(subject.interest_on_day(59, 35)).to eq 11.99
      end

      it "should return 23.49 on day 60" do
        expect(subject.interest_on_day(60, 35)).to eq 23.49
      end
    end
  end

  describe ".balance_on_day(num, apr_percent)" do
    it "should return 411.99 by the end of day 30" do
      expect(subject.balance_on_day(30, 35)).to eq 411.99
    end
  end

  describe ".next_closing_day" do
    it "should return 30" do
      expect(subject.next_closing_day).to eq 30
    end
  end
end
