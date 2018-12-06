require 'ostruct'

class Schedule
  attr_reader :input
  attr_reader :guards

  def initialize
    @guards = []
  end

  def read_file(path)
    @input = File.readlines(path).map(&:chomp!).sort
  end

  def log_sleep(guard_id, asleep_at, awake_at)
    if @guards.select { |g| g.id == guard_id }.empty?
      @guards << OpenStruct.new(id: guard_id, slept: 0, sleep_minutes: Hash.new(0))
    end

    index = @guards.index { |g| g.id == guard_id }
    guard = @guards[index]
    guard.slept += (awake_at - asleep_at) || 0

    (asleep_at...awake_at).each do |min|
      guard.sleep_minutes[min] += 1
    end
    @guards[index] = guard
  end

  def parse_activity(record)
    md = record.match(/\[\d{4}-\d{2}-\d{2}\s\d{2}:(\d{2})\](\s+Guard #(\d+))?\s+([\w\s]+)/)
    {
      minute: md[1],
      guard: md[3],
      activity: md[4]
    }
  end

  def parse_logs
    guard_id = nil
    asleep_at = nil
    awake_at = nil
    @input.each do |record|
      activity = parse_activity(record)
      if activity[:guard]
        guard_id = activity[:guard].to_i
      else
        if activity[:activity] == "falls asleep"
          asleep_at = activity[:minute].to_i
        else
          awake_at = activity[:minute].to_i
          log_sleep(guard_id, asleep_at, awake_at)
        end
      end
    end
  end

  def max_sleeper
    max = 0
    sleeper = nil

    @guards.each do |g|
      if g.slept > max
        max = g.slept
        sleeper = g
      end
    end

    sleeper
  end

  def sleepiest_minute
    times = -1
    minute = nil

    max_sleeper.sleep_minutes.each do |k,v|
      if v > times
        times = v
        minute = k
      end
    end

    minute
  end

  def answer
    id = max_sleeper.id
    id * sleepiest_minute
  end
end
