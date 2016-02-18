require 'rails_helper'

RSpec.feature "Transaction", :type => :feature do
  before do  
    visit root_path
    expect(page).to have_text "Add new transaction"
  end

  scenario "Add a new transaction within credit limit" do
    select "withdraw", from: "Transaction type"
    fill_in "Day number", :with => "1"
    fill_in "Amount", :with => "5000"

    click_button "Submit"

    expect(page).to have_text("New transaction added.")
  end

  scenario "Add a new transaction that will exceed credit limit" do
    select "withdraw", from: "Transaction type"
    fill_in "Day number", :with => "1"
    fill_in "Amount", :with => "5001"

    click_button "Submit"

    expect(page).to have_text("Can not exceed credit limit of 5000!")
  end
end