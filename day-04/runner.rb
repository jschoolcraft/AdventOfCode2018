Dir["./lib/*.rb"].each { |file| require file }

s = Schedule.new

s.read_file('input.txt')
s.parse_logs

puts "Part 1 Result: #{s.answer}"
