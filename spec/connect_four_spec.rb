require_relative "../lib/connect_four"

describe ConnectFour do
  let(:horizontal_win){
    [%w(R B R R _ _ _),
     %w(B B R B R _ _),
     %w(R R B R R B _),
     %w(B R R B B R B),
     %w(B B R R R R B),
     %w(R B R B B B R),
     %w(B R B B R B R)]
  }

  let(:vertical_win){ horizontal_win.transpose }

  it "knows when there is no win" do
    board = [%w(R B _ R _ _ _),
             %w(B _ R B R _ _),
             %w(R _ B R R B _),
             %w(B R R _ B R B),
             %w(B B _ R _ _ R),
             %w(_ B R B _ B R),
             %w(B R B _ R B R)]

    expect(ConnectFour.win?(board)).to be(false)
  end

  it "detects horizontal wins", :focus do
    expect(ConnectFour.win?(horizontal_win)).to be(true)
  end

  it "detects vertical wins" do
    expect(ConnectFour.win?(vertical_win)).to be(true)
  end

  it "detects right diagonal wins" do
    board = [%w(B B R R _ _ _),
             %w(B B R B R _ _),
             %w(R R B R R B _),
             %w(B R R B B R B),
             %w(B B R R R B R),
             %w(R B R B B B R),
             %w(B R B B R B R)]

    expect(ConnectFour.win?(board)).to be(true)
  end

  it "detects left diagonal wins" do
    board = [ %w(B B R R _ _ _),
              %w(B R R B R _ _),
              %w(R R B R R B _),
              %w(R R R B B R B),
              %w(B B R R R B R),
              %w(R B R B B B R),
              %w(B R B B R B R)]

    expect(ConnectFour.win?(board)).to be(true)
  end

end
