class Marker
  def initialize(code)
    @code = code.split(" ")
  end

  def guess(check_val)
    check_val_chars = check_val.split(" ")
    matches = right_place_matches(check_val_chars)
    wrong_place_count = wrong_places(check_val_chars, matches)
    "x" * matches.size << "o" * wrong_place_count
  end

  private
  def right_place_matches(check_val_chars)
    zipped = @code.zip(check_val_chars)
    zipped.select{|c| c.uniq.size == 1}.map{|c| c.first }
  end

  def wrong_places(check_val_chars, matches)
    reduced_code = remove_matched(@code, matches)
    remove_matched(check_val_chars, matches).
      select{|c| reduced_code.include?(c) }.size
  end

  def remove_matched(code, hits)
    hits.inject(code) do |memo, v|
      i = memo.index(v)
      memo[0,i].concat(memo[i+1, memo.size - 1])
    end
  end
end
