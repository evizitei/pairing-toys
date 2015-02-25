module Products
  def self.get_products_of_all_ints_except_at_index(ints)
    output = Array.new(ints.size, 1)

    # vals before index
    product_so_far = 1
    (0..(ints.size-1)).each do |index|
      output[index] = product_so_far
      product_so_far *= ints[index]
    end

    # vals after index
    product_so_far = 1
    (0..(ints.size - 1)).to_a.reverse.each do |index|
      output[index] *= product_so_far
      product_so_far *= ints[index]
    end

    return output
  end

end
