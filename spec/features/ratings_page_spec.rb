require 'rails_helper'

include Helpers

describe "Rating" do
  let!(:brewery) { FactoryBot.create :brewery, name: "Koff" }
  let!(:beer1) { FactoryBot.create :beer, name: "iso 3", brewery:brewery }
  let!(:beer2) { FactoryBot.create :beer, name: "Karhu", brewery:brewery }
  let!(:user) { FactoryBot.create :user }

  before :each do
    sign_in(username: "Pekka", password: "Foobar1")
  end

  it "when given, is registered to the beer and user who is signed in" do
    visit new_rating_path
    select('iso 3', from: 'rating[beer_id]')
    fill_in('rating[score]', with: '15')

    expect{
      click_button "Create Rating"
    }.to change{Rating.count}.from(0).to(1)

    expect(user.ratings.count).to eq(1)
    expect(beer1.ratings.count).to eq(1)
    expect(beer1.average_rating).to eq(15.0)
  end

  describe "when several ratings exist" do
    let!(:rating1) { FactoryBot.create(:rating, beer: beer1, user: user) }
    let!(:rating2) { FactoryBot.create(:rating, score: 20, beer: beer2, user: user) }

    it "shows the number of ratings on the ratings page" do
      visit ratings_path

      expect(page).to have_content "Number of ratings: 2"

      expect(page).to have_content "iso 3 10 Pekka"
      expect(page).to have_content "Karhu 20 Pekka"
    end

    it "shows the number of ratings on the user page" do
      visit user_path(user)

      expect(page).to have_content "Has made 2 ratings with an average of 15.0"
    end

    it "user can delete a rating" do
      visit user_path(user)

      expect{
        page.all('button')[1].click
      }.to change{Rating.count}.by(-1)
    end
  end
end
