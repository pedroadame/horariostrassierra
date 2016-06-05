class Time
  class << self
    def mocked_now
      Time.now.change(day: 3, hour: "10:00")
    end
  end
end