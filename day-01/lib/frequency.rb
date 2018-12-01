class Frequency
  attr_reader :frequency
  attr_reader :first_duplicate

  def initialize
    @frequency = 0
    @frequencies = [0]
  end

  def adjust(adjustment)
    @frequency += adjustment

    if !duplicate? && @frequencies.include?(@frequency)
      @first_duplicate = @frequency
    end

    @frequencies << @frequency
  end

  def duplicate?
    @first_duplicate
  end

  def read_input_as_array(path)
    inputs = []
    File.open(path) do |file|
      file.each do |line|
        inputs << line.chomp!.to_i
      end
    end
    inputs
  end

  def process_file(path)
    inputs = read_input_as_array(path)
    inputs.each { |i| adjust(i) }
  end

  def find_duplicate(path)
    inputs = read_input_as_array(path)
    until duplicate? do
      inputs.each { |adj| adjust(adj) }
    end
  end
end
