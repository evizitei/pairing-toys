class Cache
  def initialize(opts = {})
    @timeout  = opts[:timeout] || 30
    @max_size = opts[:max_size] || 10**10
    @state    = {}
  end

  def get(key)
    value = state[key].nil? ? nil : state[key].value
    unless state.has_key?(key) && !value.nil?
      set(key, yield) if block_given?
    end

    state.has_key?(key) ? state[key].value : nil
  end

  def set(key, val)
    state[key] = Cache::Entry.new(val, timeout)
    clean_old

    val
  end

  private

  attr_reader :state, :timeout, :max_size

  def clean_old
    if state.length > max_size
      state.to_a.sort do |x,y|
        x.last.heat <=> y.last.heat
      end.map(&:first)[0..(state.length - max_size)].each do |key|
        state.delete(key)
      end
    end
  end
end

class Cache::Entry
  attr_reader :time, :timeout, :heat
  def initialize(value, ttl)
    @value   = value
    @timeout = Time.now + ttl
    @heat    = 0
  end

  def value
    @heat += 1
    @value = nil if timeout < Time.now
    @value
  end
end
