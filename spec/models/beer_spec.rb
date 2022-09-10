require 'rails_helper'

RSpec.describe Beer, type: :model do
  it "is not saved without a brewery" do
    beer = Beer.create name: "testbeer", style: "teststyle"
  end

  describe "with existing brewery" do
    let(:brewery) { Brewery.create name: "test", year: 2000 }

    it "is saved with a name, style and brewery" do
      beer = Beer.create name: "testbeer", style: "teststyle", brewery_id: brewery.id

      expect(beer).to be_valid
      expect(Beer.count).to eq(1)
    end

    it "is not saved without a name" do
      beer = Beer.create style: "teststyle", brewery_id: brewery.id

      expect(beer).not_to be_valid
      expect(Beer.count).to eq(0)
    end

    it "is not saved without a style" do
      beer = Beer.create name: "testbeer", brewery_id: brewery.id

      expect(beer).not_to be_valid
      expect(Beer.count).to eq(0)
    end
  end
end
