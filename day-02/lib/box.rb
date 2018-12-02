class Box
  def find_multiples(id, times)
    chars = id.chars
    uniqs = chars.uniq
    return 0 if uniqs.count == chars.count
    matches = uniqs.map do |u|
      chars.select { |c| u == c }
    end
    counts = matches.uniq.map(&:count).uniq
    counts.select { |c| c == times }.count
  end

  def find_doubles(id)
    find_multiples(id, 2)
  end

  def find_triples(id)
    find_multiples(id, 3)
  end

  def find_all_doubles(input)
    input.map { |i| find_doubles(i) }.reduce(:+)
  end

  def find_all_triples(input)
    input.map { |i| find_triples(i) }.reduce(:+)
  end

  def checksum(input)
    find_all_doubles(input) * find_all_triples(input)
  end

  def checksum_file(path)
    inputs = []
    File.open(path) do |file|
      file.each do |line|
        inputs << line.chomp!
      end
    end

    checksum(inputs)
  end
end
