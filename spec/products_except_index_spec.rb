require_relative "../lib/products.rb"

describe Products do
  describe ".get_products_of_all_ints_except_at_index" do
    it "calculates correct results" do
      input = [1,7,3,4]
      output = Products.get_products_of_all_ints_except_at_index(input)
      expect(output).to eq([84,12,28,21])
    end

    it "handles an array with zeros" do
      input = [1,2,0,3,4]
      output = Products.get_products_of_all_ints_except_at_index(input)
      expect(output).to eq([0,0,24,0,0])
    end
  end
end
