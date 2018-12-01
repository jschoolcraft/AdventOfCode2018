require 'frequency'

RSpec.describe Frequency do
  context "adjustments" do
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
  end

  context "first duplicate" do
    it "should start at nil" do
      f = Frequency.new

      expect(f.first_duplicate).to eq nil
    end

    it "reaches first reaches 0 twice" do
      f = Frequency.new

      inputs = [1, -1]

      until f.duplicate? do
        inputs.each { |adj| f.adjust(adj) }
      end

      expect(f.first_duplicate).to eq 0
    end

    it "reaches first reaches 10 twice" do
      f = Frequency.new

      inputs = [3, 3, 4, -2, -4]

      until f.duplicate? do
        inputs.each { |adj| f.adjust(adj) }
      end

      expect(f.first_duplicate).to eq 10
    end
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

  it "should find the duplicate" do
    f = Frequency.new
    f.find_duplicate('./spec/sample2.txt')

    expect(f.first_duplicate).to be 10
  end

end
