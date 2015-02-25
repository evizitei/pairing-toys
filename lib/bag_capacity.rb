module BagCapacity
  def self.max_value(tuples, capacity)
    tuples = tuples.select{|t| t[0] != 0 || t[1] != 0}
    begin
      sorted_tuples = tuples.sort do |tup1, tup2|
        tup2[1]/tup2[0] <=> tup1[1]/tup1[0]
      end
    rescue ZeroDivisionError
      return Float::INFINITY
    end

    filled_weight = 0
    bag_value = 0
    tup_index = 0

    sorted_tuples.each do |tuple|
      remainder = capacity - filled_weight
      break if filled_weight >= capacity
      weight_per = tuple[0]
      count = (remainder / weight_per).floor
      filled_weight += count * weight_per
      bag_value += count * tuple[1]
    end

    return bag_value
  end
end
