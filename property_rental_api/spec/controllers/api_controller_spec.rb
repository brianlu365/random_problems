require 'rails_helper'

RSpec.describe ApiController, type: :controller do

  describe "POST #price" do
    it "returns 404 when zipcode not found" do
      headers = {
        "ACCEPT" => "application/json",
      }
      post :price, {"zipcode": 123, "bedroom_count": 2}
      expect(response).to have_http_status(404)
    end

    it "returns price in json" do
      headers = {
        "ACCEPT" => "application/json",
      }
      post :price, {"zipcode": 94133, "bedroom_count": 2}
      expect(response.content_type).to eq("application/json")
      expect(response).to have_http_status(200)
    end
  end

  describe "POST #booking_rate" do
    it "returns booking rate in json" do
      headers = {
        "ACCEPT" => "application/json",
      }
      post :booking_rate, {"zipcode": 94133, "bedroom_count": 2}
      expect(response.content_type).to eq("application/json")
      expect(response).to have_http_status(200)
    end
  end

  describe "POST #earnings" do
    it "returns earnings in json" do
      headers = {
        "ACCEPT" => "application/json",
      }
      post :earnings, {"start_date": "2015-01-01", "end_date": "2015-01-02", "zipcode": 94133, "bedroom_count": 2}
      expect(response.content_type).to eq("application/json")
      expect(response).to have_http_status(200)
    end
  end

end
