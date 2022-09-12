require 'rails_helper'

describe "Places" do
  before :each do
    Rails.cache.clear
  end

  it "if one is returned by the API, it is shown at the page" do
    allow(BeermappingApi).to receive(:get_places_in).with("kumpula").and_return(
      [ Place.new( name: "Oljenkorsi", id: 1 ) ]
    )

    allow(WeatherstackApi).to receive(:weather_for).with("kumpula").and_return(
      nil
    )

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content "Oljenkorsi"
  end

  it "if multiple are returned by the API, they are shown at the page" do
    allow(BeermappingApi).to receive(:get_places_in).with("kumpula").and_return(
      [ Place.new( name: "Oljenkorsi", id: 1 ), Place.new( name: "testbar", id: 2 ) ]
    )

    allow(WeatherstackApi).to receive(:weather_for).with("kumpula").and_return(
      nil
    )

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content "Oljenkorsi"
    expect(page).to have_content "testbar"
  end

  it "if none are returned by the API, notice is shown at the page" do
    allow(BeermappingApi).to receive(:get_places_in).with("kumpula").and_return(
      []
    )

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content "No locations in kumpula"
  end
end
