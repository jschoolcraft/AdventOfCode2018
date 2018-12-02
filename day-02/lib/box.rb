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

  def input_file_to_array(path)
    inputs = []
    File.open(path) do |file|
      file.each do |line|
        inputs << line.chomp!
      end
    end

    inputs
  end

  def checksum_file(path)
    inputs = input_file_to_array(path)

    checksum(inputs)
  end

  def same_chars(a, b)
    same = ''
    a.chars.each_with_index { |c, i| same += c if c == b.chars[i]  }
    same
  end

  def diff_chars_count(a, b)
    a.length - same_chars(a, b).length
  end

  def find_similar_ids(inputs)
    similar_ids = []
    0.upto(inputs.count - 2) do |i|
      (i+1).upto(inputs.count - 1) do |j|
        # puts "diff_chars_count(#{inputs[i]}, #{inputs[j]}) => #{diff_chars_count(inputs[i], inputs[j])}"

        if diff_chars_count(inputs[i], inputs[j]) == 1
          similar_ids << inputs[i]
          similar_ids << inputs[j]
        end
      end
    end
    similar_ids
  end

  def common_characters_in_similar_ids(inputs)
    similar_ids = find_similar_ids(inputs)
    same_chars(similar_ids.first, similar_ids.last)
  end
end
