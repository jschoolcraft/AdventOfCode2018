require 'frequency'

RSpec.describe Frequency do
  it "should start with a frequency of 0" do
    f = Frequency.new

    expect(f.frequency).to be 0
  end

  it "should adjust frequency" do
    f = Frequency.new

    [1, -2, 3, 1].each do |adj|
      f.adjust(adj)
    end

    expect(f.frequency).to be 3
  end

  it "should adjust frequency" do
    f = Frequency.new

    [1, 1, 1].each do |adj|
      f.adjust(adj)
    end

    expect(f.frequency).to be 3
  end

  it "should adjust frequency" do
    f = Frequency.new

    [1, 1, -2].each do |adj|
      f.adjust(adj)
    end

    expect(f.frequency).to be 0
  end

  it "should adjust frequency" do
    f = Frequency.new

    [-1, -2, -3].each do |adj|
      f.adjust(adj)
    end

    expect(f.frequency).to be -6
  end

  it "should handle file input" do
    f = Frequency.new

    File.open('./spec/sample.txt') do |file|
      file.each do |line|
        f.adjust(line.chomp!.to_i)
      end
    end

    expect(f.frequency).to be -6
  end

  it "should process a file" do
    f = Frequency.new
    f.process_file('./spec/sample.txt')

    expect(f.frequency).to be -6
  end
end
