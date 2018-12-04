Dir["./lib/*.rb"].each { |file| require file }

f = Fabric.new
# overlap = f.process_overlap('./input.txt')
# puts "Part 1 Result: #{overlap}"


i = f.intact('./input.txt')
puts i
