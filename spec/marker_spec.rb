require_relative "../lib/marker"

describe Marker do
  describe 'markers with unique values' do
    let(:marker){ Marker.new("a b c d") }

    it "returns an empty string for no guess" do
      expect(marker.guess("")).to eq("")
    end

    it "returns an empty string if no chars match" do
      expect(marker.guess("x x x x")).to eq("")
    end

    it "returns one x if there is one character match" do
      expect(marker.guess("a x x x")).to eq("x")
    end

    it "returns two x's if there are two matches" do
      expect(marker.guess("a b x x")).to eq("xx")
    end
    it "returns three x's if there are two matches" do
      expect(marker.guess("a b c x")).to eq("xxx")
    end

    it "returns two x's if there are two matches" do
      expect(marker.guess("a b c d")).to eq("xxxx")
    end

    it "returns o for right char wrong place" do
      expect(marker.guess("x a x x")).to eq("o")
    end

    it "combines x and o appropriately" do
      expect(marker.guess("a x b x")).to eq("xo")
    end

    it "returns all os for jumbled solution" do
      expect(marker.guess("b a d c")).to eq("oooo")
    end

    it "doesnt reuse wrong place markers from used characters" do
      expect(marker.guess("a a a a")).to eq("x")
    end
  end

  describe "marker with repeated values" do
    let(:marker){ Marker.new("a b a b") }

    it "returns one x for a correct match" do
      expect(marker.guess("x x a x")).to eq("x")
    end

    it "returns one o for a wrong-place match" do
      expect(marker.guess("x x x a")).to eq("o")
    end

    it 'combines x and o sufficiently' do
      expect(marker.guess("x x a a")).to eq("xo")
    end
  end
end
