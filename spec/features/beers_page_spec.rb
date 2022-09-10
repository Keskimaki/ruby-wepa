require 'rails_helper'

include Helpers

describe "Beer" do
  before :each do
    FactoryBot.create :user
    sign_in(username: "Pekka", password: "Foobar1")
  end

  it "is created when name given" do
    FactoryBot.create(:brewery)

    visit new_beer_path
    fill_in('beer_name', with: 'Testbeer')

    expect{
      click_button "Create Beer"
    }.to change{Beer.count}.from(0).to(1)
  end

  it "is not created when invalid name is given" do
    FactoryBot.create(:brewery)

    visit new_beer_path
    fill_in('beer_name', with: '')

    expect{
      click_button "Create Beer"
    }.to change{Beer.count}.by(0)

    expect(page).to have_content "Name can't be blank"
  end
end
