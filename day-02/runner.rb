Dir["./lib/*.rb"].each { |file| require file }

b = Box.new
checksum = b.checksum_file('./input.txt')

puts "Part 1 Result: #{checksum}"

b2 = Box.new
inputs = b2.input_file_to_array('./input.txt')

puts "Part 2 Result: #{b2.common_characters_in_similar_ids(inputs)}"
