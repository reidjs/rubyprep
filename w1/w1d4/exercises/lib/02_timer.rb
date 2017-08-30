class Timer
  attr_accessor :seconds, :time_string
  def initialize
    @seconds = 0
  end
  def time_string
    hrs = 0
    mins = 0
    secs = @seconds
    while secs >= 60*60
      hrs += 1
      secs -= 60*60
    end
    while secs >= 60
      mins += 1
      secs -= 60
    end
    hrs = "0"+hrs.to_s if hrs < 10
    mins = "0"+mins.to_s if mins < 10
    secs = "0"+secs.to_s if secs < 10
    @time_string = "#{hrs}:#{mins}:#{secs}"
  end
end
