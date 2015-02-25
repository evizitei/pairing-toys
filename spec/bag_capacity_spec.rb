require_relative '../lib/bag_capacity'

describe BagCapacity do
  describe ".max_value" do
    it 'finds the maximum value combination' do
      tups = [[7,160], [3,90], [2,15]]
      capacity = 20
      val = BagCapacity.max_value(tups, capacity)
      expect(val).to eq(555)
    end

    it 'can handle a very simple case' do
      tups = [[1,1]]
      capacity = 20
      val = BagCapacity.max_value(tups, capacity)
      expect(val).to eq(20)
    end

    it 'can handle a microscopic duffle' do
      tups = [[7,160], [3,90], [2,15]]
      capacity = 0
      val = BagCapacity.max_value(tups, capacity)
      expect(val).to eq(0)
    end

    it 'can handle a weightless cake' do
      tups = [[7,160], [0,90], [2,15]]
      capacity = 0
      val = BagCapacity.max_value(tups, capacity)
      expect(val).to eq(Float::INFINITY)
    end

    it 'can handle a weightless and valueluess cake' do
      tups = [[7,160], [0,0], [2,15]]
      capacity = 20
      val = BagCapacity.max_value(tups, capacity)
      expect(val).to eq(365)
    end
  end
end
