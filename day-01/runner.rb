Dir["./lib/*.rb"].each { |file| require file }

f = Frequency.new
f.process_file('./input.txt')

puts "Part 1 Result: #{f.frequency}"

f2 = Frequency.new
f2.find_duplicate('./input.txt')
puts "Part 2: First reaches #{f2.first_duplicate} twice."
