Dir["./lib/*.rb"].each { |file| require file }

b = Box.new
checksum = b.checksum_file('./input.txt')

puts "Part 1 Result: #{checksum}"

