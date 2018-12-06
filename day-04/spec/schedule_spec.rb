require 'schedule'

RSpec.describe Schedule do
  context "Part 1" do
    it "should read input from a file" do
      s = Schedule.new

      s.read_file('sample.txt')
      expect(s.input.count).to eq(17)
    end

    it "should sort input from a file" do
      s = Schedule.new

      s.read_file('sample.txt')

      expect(s.input.first).to eq("[1518-11-01 00:00] Guard #10 begins shift")
      expect(s.input.last).to eq("[1518-11-05 00:55] wakes up")
    end

    it "should parse the guards activity" do
      s = Schedule.new

      s.read_file('sample.txt')
      s.parse_logs

      expect(s.guards.index { |g| g.id == 10 && g.slept == 50}).not_to be_nil
      expect(s.guards.index { |g| g.id == 99 && g.slept == 30}).not_to be_nil
    end

    it "should parse a single record" do
      s = Schedule.new

      expect(s.parse_activity("[1518-11-01 00:00] Guard #10 begins shift")).to eq({
        minute: "00",
        guard: "10",
        activity: "begins shift"
      })

      expect(s.parse_activity("[1518-11-05 00:55] wakes up")).to eq({
        minute: "55",
        guard: nil,
        activity: "wakes up"
      })

      expect(s.parse_activity("[1518-11-05 00:45] falls asleep")).to eq({
        minute: "45",
        guard: nil,
        activity: "falls asleep"
      })
    end

    it "should find the max sleeper" do
      s = Schedule.new

      s.read_file('sample.txt')
      s.parse_logs

      expect(s.max_sleeper.id).to eq(10)
      expect(s.max_sleeper.slept).to eq(50)
    end

    it "should find the sleepiest minute" do
      s = Schedule.new

      s.read_file('sample.txt')
      s.parse_logs

      expect(s.sleepiest_minute(s.max_sleeper)[:minute]).to eq(24)
    end

    it "should find the answer" do
      s = Schedule.new

      s.read_file('sample.txt')
      s.parse_logs

      expect(s.part1_answer).to eq(240)
    end
  end

  context "Part 2" do
    it "should find the highest frequency minute of a guard" do
      s = Schedule.new

      s.read_file('sample.txt')
      s.parse_logs

      guard_99 = s.guards.select { |g| g.id == 99 }.first
      expect(guard_99).to_not be_nil
      expect(s.sleepiest_minute(guard_99)).to include({minute: 45})
    end

    it "should find the guard with the highest frequency minute" do
      s = Schedule.new

      s.read_file('sample.txt')
      s.parse_logs

      expect(s.most_consistent_guard.id).to eq(99)
    end

    it "should find the answer to part 2" do
      s = Schedule.new

      s.read_file('sample.txt')
      s.parse_logs

      expect(s.part2_answer).to eq(4455)
    end
  end
end
