require 'box'

RSpec.describe Box do
  context "Checksum" do
    it "should find doubles" do
      b = Box.new

      expect(b.find_doubles('abcdef')).to be 0
      expect(b.find_doubles('bababc')).to be 1
      expect(b.find_doubles('abbcde')).to be 1
      expect(b.find_doubles('abcccd')).to be 0
      expect(b.find_doubles('aabcdd')).to be 1
      expect(b.find_doubles('abcdee')).to be 1
      expect(b.find_doubles('ababab')).to be 0
    end

    it "should find triples" do
      b = Box.new

      expect(b.find_triples('abcdef')).to be 0
      expect(b.find_triples('bababc')).to be 1
      expect(b.find_triples('abbcde')).to be 0
      expect(b.find_triples('abcccd')).to be 1
      expect(b.find_triples('aabcdd')).to be 0
      expect(b.find_triples('abcdee')).to be 0
      expect(b.find_triples('ababab')).to be 1
    end

    it "should find all doubles in the input" do
      b = Box.new
      input = %w[ abcdef bababc abbcde abcccd aabcdd abcdee ababab ]

      expect(b.find_all_doubles(input)).to be 4
    end

    it "should find all triples in the input" do
      b = Box.new
      input = %w[ abcdef bababc abbcde abcccd aabcdd abcdee ababab ]

      expect(b.find_all_triples(input)).to be 3
    end

    it "should calculate checksum" do
      b = Box.new
      input = %w[ abcdef bababc abbcde abcccd aabcdd abcdee ababab ]

      expect(b.checksum(input)).to be 12
    end

    it "should calculate checksum from a file of inputs" do
      b = Box.new

      expect(b.checksum_file('./sample.txt')).to be 12
    end
  end

  context "Something else" do
    b = Box.new

    inputs = %w(abcde axcye)

    expect(b.same_chars(input)).to be %w(ace ace)
  end
end
