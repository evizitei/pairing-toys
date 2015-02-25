require_relative "../lib/missing_delivery"

describe MissingDelivery do
  describe ".find" do
    it "finds the one that didn't come back" do
      input = [1,3,5,1,5,2,3,4,4,9,8,7,7,8,9]
      expect(MissingDelivery.find(input)).to eq([2])
    end
  end
end
