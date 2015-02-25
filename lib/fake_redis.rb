
class FakeRedis

  def initialize(default_value: nil, global_timeout: nil)
    @data = {}
    @default_value = default_value
    @timeout = global_timeout
  end

  def get(key)
    cache_entry = fetch(key)
    return default_value if expired?(cache_entry)
    cache_entry[:data]
  end

  def set(key, val, key_timeout: nil)
    data[key] = create_entry(val, key_timeout || timeout)
  end

  private
  attr_reader :data, :default_value, :timeout

  def fetch(key)
    data.fetch(key){ create_entry(default_value, nil) }
  end

  def expired?(cache_entry)
    return false if cache_entry[:expiration].nil?
    Time.now > cache_entry[:expiration]
  end

  def create_entry(data, entry_timeout)
    expires = entry_timeout.nil? ? nil : Time.now + entry_timeout
    { data: data, expiration: expires }
  end
end
