Dir["./lib/*.rb"].each { |file| require file }

f = Frequency.new
f.process_file('./input.txt')

puts "Result: #{f.frequency}"
