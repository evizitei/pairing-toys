module MissingDelivery
  def self.find(input)
    tracker = {}
    input.each do |id|
      if tracker[id]
        tracker.delete(id)
      else
        tracker[id] = true
      end
    end
    tracker.keys
  end
end
