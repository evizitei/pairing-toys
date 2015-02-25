require_relative "../lib/mastermind"

describe Mastermind do
  context "for unique code characters" do
    let(:victory){ "a b c d" }
    let(:board) { Mastermind.new(victory) }

    it "returns an empty string for all wrong characters" do
      expect(board.guess("x x x x")).to eq("")
    end

    it "returns a victory when all the characters match" do
      expect(board.guess(victory)).to eq("xxxx")
    end

    it "returns o characters for right char wrong spot" do
      expect(board.guess("b a x x")).to eq("oo")
    end

    it "can mix x and o responses" do
      expect(board.guess("a x b x")).to eq("xo")
      expect(board.guess("x x a d")).to eq("xo")
    end

  end


  context "for duplicated characters" do
    let(:victory){ "a b b a" }
    let(:board){ Mastermind.new(victory)}

    it "doesnt over-report right character in wrong spot" do
      expect(board.guess("a a a x")).to eq("xo")

      #find_direc_match_indices => [0]
      #indirect_code =>  [a b b]
      #indirect_check => [a a x]
      # [b b]
      # [a x]
    end
  end
end
