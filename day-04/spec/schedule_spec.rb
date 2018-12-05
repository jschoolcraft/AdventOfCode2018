require 'schedule'

RSpec.describe Schedule do
  it "should work" do
    expect(true).to eq(true)
  end

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

    expect(s.guards).to include({"10"=>include({:slept=>50})})
    expect(s.guards).to include({"99"=>include({:slept=>30})})
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

    expect(s.max_sleeper).to include({"10"=>include({:slept=>50})})
  end

  it "should find the sleepiest minute" do
    s = Schedule.new

    s.read_file('sample.txt')
    s.parse_logs

    expect(s.sleepiest_minute).to eq(24)
  end

  it "should find the answer" do
    s = Schedule.new

    s.read_file('sample.txt')
    s.parse_logs

    expect(s.answer).to eq(240)
  end
end
