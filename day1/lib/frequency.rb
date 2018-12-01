class Frequency
  attr_reader :frequency

  def initialize
    @frequency = 0
  end

  def adjust(adjustment)
    @frequency += adjustment
  end

  def process_file(path)
    File.open(path) do |file|
      file.each do |line|
        adjust(line.chomp!.to_i)
      end
    end
  end
end
