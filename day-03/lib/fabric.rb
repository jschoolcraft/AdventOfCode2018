class Fabric
  def claimed_squares(input)
    claimed = []

    md = /#(\d+)\s@\s(\d+),(\d+):\s(\d+)x(\d+)/.match(input)
    id = md[1]

    left = md[2].to_i
    top = md[3].to_i
    width = md[4].to_i
    height = md[5].to_i

    left.upto(left + width - 1) do |x|
      top.upto(top + height - 1) do |y|
        claimed << [x,y]
      end
    end

    claimed
  end

  def overlap(claims)
    claims.flatten!(1)

    i = 1
    c = Hash.new(0)
    claims.each do |e|
      i += 1
      c["#{e.first},#{e.last}"] += 1
    end

    overlapping = c.select! { |k,v| v > 1 }
    overlapping && overlapping.keys.count
  end

  def process_overlap(path)
    claims = []
    count = 0

    File.open(path) do |file|
      file.each do |line|
        cs = claimed_squares(line.chomp!)
        # puts "Claimed squares: #{line} => #{cs.count}"
        claims << cs
        count += 1
      end
    end
    overlap(claims)
  end

  def process_overlap_array(input)
    claims = []
    count = 0

    input.each do |line|
      cs = claimed_squares(line)
      claims << cs
      count += 1
    end
    overlap(claims)
  end

  def any_overlap?(target, rest)
    rest.flatten!(1)
    count = rest.count

    (rest - target).count == count
  end

  def intact(path)
    overlaps = process_overlap(path)
    lines = File.readlines(path).map(&:chomp!)

    puts "Processing #{lines.count} variations"
    count = 0
    unique = nil
    lines.each do |l|
      count += 1
      puts "Processing #{count}..."
      warray = lines.select { |v| v != l}

      if any_overlap?(claimed_squares(l), warray.map { |l| claimed_squares(l)})
        unique = l
      end
    end
    puts "Only valid claim is: "
    unique
  end
end
