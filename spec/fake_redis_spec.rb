require_relative "../lib/fake_redis"
require 'timecop'

describe FakeRedis do
  context "getting and setting" do
    let(:fake_redis) { FakeRedis.new }

    context "#get" do
      it "returns nil for missing keys" do
        expect(fake_redis.get("a")).to be_nil
      end

      it "can set a default value for missing keys" do
        default_redis = FakeRedis.new(default_value: "")
        expect(default_redis.get("a")).to eq("")
      end
    end

    context "#set" do
      it "sets a value for a key" do
        fake_redis.set("a", "b")
        expect(fake_redis.get("a")).to eq("b")
      end
    end
   end

  context "global expriration" do
    let(:fake_redis) { FakeRedis.new(global_timeout: 5) }

    context "before timeout expires" do
      it "returns the value" do
        fake_redis.set("a", "b")
        Timecop.freeze do
          expect(fake_redis.get("a")).to eq("b")
        end
      end
    end

    context "after timeout expires" do
      it "returns nil" do
        fake_redis.set("a", "b")
        Timecop.travel(Time.now + 10) do
          expect(fake_redis.get("a")).to be_nil
        end
      end
    end

    context "with key specific override" do
      after{ Timecop.return }

      it "favors a shorter key timeout" do
        Timecop.freeze
        fake_redis.set("a", "b")
        fake_redis.set("c", "d", key_timeout: 2)
        Timecop.travel(Time.now + 3)
        expect(fake_redis.get('a')).to eq('b')
        expect(fake_redis.get('c')).to be_nil
      end

      it "favors a longer key timeout" do
        Timecop.freeze
        fake_redis.set("a", "b")
        fake_redis.set("c", "d", key_timeout: 10)
        Timecop.travel(Time.now + 7)
        expect(fake_redis.get('a')).to be_nil
        expect(fake_redis.get('c')).to eq("d")
      end
    end
  end

end
