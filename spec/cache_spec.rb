require 'timecop'
require_relative "../lib/cache"

describe Cache do

  class FakeService
    attr_reader :call_count
    def initialize
      @call_count = 0
    end

    def execute
      @call_count += 1
      "FooBar"
    end
  end

  let(:cache){ Cache.new }
  let(:service){ FakeService.new }

  it 'acts like any other cache' do
    expect(cache.get(:key)).to be(nil)
    cache.set(:key, "Some Value")
    expect(cache.get(:key)).to eq("Some Value")
  end

  it 'returns the set value for convenience' do
    expect(cache.set(:key, "Value")).to eq("Value")
  end

  it 'accepts a block for the value calcuation if not in the cache' do
    expect(cache.get(:key){ "Foo" }).to eq("Foo")
  end

  it "caches a block value to prevent multiple expensive calls" do
    10.times{ cache.get(:key){ service.execute } }
    expect(cache.get(:key)).to eq("FooBar")
    expect(service.call_count).to eq(1)
  end

  describe "with timeout" do
    let(:cache){ Cache.new(timeout: 60) }

    before do
      Timecop.freeze
      cache.set(:key, :value)
      expect(cache.get(:key)).to eq(:value)
      Timecop.travel(Time.now + 61)
    end

    after { Timecop.return }

    it 'should report nil on an expired timeout' do
      expect(cache.get(:key)).to be(nil)
    end

    it 'uses a block override after timeout expired' do
      expect(cache.get(:key){"foo" }).to eq("foo")
    end

    it 'doesnt consider nil a valid value' do
      cache.set(:key, nil)
      expect(cache.get(:key){ "Foo" }).to eq("Foo")
    end

  end

  describe 'intelligent discarding of excess volume' do
    let(:cache){ Cache.new(max_size: 10) }

    it "kicks out old keys when at max size" do
      10.times {|i| cache.set(i.to_s, i) }
      cache.set("10", 10)
      expect(cache.get("0")).to be_nil
      expect(cache.get("10")).to eq(10)
    end

    it 'chooses which key to boot based on usage' do
      10.times {|i| cache.set(i.to_s, i) }
      cache.get("0") # throwaway for cache usage
      cache.set("10", 10)
      expect(cache.get("0")).to eq(0)
      expect(cache.get("1")).to be_nil
    end

  end

end
