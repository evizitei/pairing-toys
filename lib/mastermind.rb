class Mastermind

  attr_reader :code

  def initialize(code)
    @code = code.split(" ")
  end

  def guess(check)
    check_array = check.split(" ")

    direct_match_indices = matched_indices(@code, check_array)

    indirect_code = reduce_matches(@code, direct_match_indices)
    indirect_check = reduce_matches(check_array, direct_match_indices)

    indirect_match_indices = matched_indices(indirect_code, indirect_check)

    "x" * direct_match_indices.size + "o" * indirect_match_indices.size
  end


  private

  def matched_indices(source, check_array)
    (0...check_array.size).select do |idx|
      source[idx] == check_array[idx]
    end
  end

  def reduce_matches(array, indices)
    array.dup.tap do |arr|
      indices.reverse.each { |idx| arr.delete_at(idx) }
    end.sort
  end

end
