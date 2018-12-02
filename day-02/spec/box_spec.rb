require 'box'

RSpec.describe Box do
  context "Checksum" do
    it "should find doubles" do
      b = Box.new

      expect(b.find_doubles('abcdef')).to eq 0
      expect(b.find_doubles('bababc')).to eq 1
      expect(b.find_doubles('abbcde')).to eq 1
      expect(b.find_doubles('abcccd')).to eq 0
      expect(b.find_doubles('aabcdd')).to eq 1
      expect(b.find_doubles('abcdee')).to eq 1
      expect(b.find_doubles('ababab')).to eq 0
    end

    it "should find triples" do
      b = Box.new

      expect(b.find_triples('abcdef')).to eq 0
      expect(b.find_triples('bababc')).to eq 1
      expect(b.find_triples('abbcde')).to eq 0
      expect(b.find_triples('abcccd')).to eq 1
      expect(b.find_triples('aabcdd')).to eq 0
      expect(b.find_triples('abcdee')).to eq 0
      expect(b.find_triples('ababab')).to eq 1
    end

    it "should find all doubles in the input" do
      b = Box.new
      input = %w[ abcdef bababc abbcde abcccd aabcdd abcdee ababab ]

      expect(b.find_all_doubles(input)).to eq 4
    end

    it "should find all triples in the input" do
      b = Box.new
      input = %w[ abcdef bababc abbcde abcccd aabcdd abcdee ababab ]

      expect(b.find_all_triples(input)).to eq 3
    end

    it "should calculate checksum" do
      b = Box.new
      input = %w[ abcdef bababc abbcde abcccd aabcdd abcdee ababab ]

      expect(b.checksum(input)).to eq 12
    end

    it "should calculate checksum from a file of inputs" do
      b = Box.new

      expect(b.checksum_file('./sample.txt')).to eq 12
    end
  end

  context "Something else" do
    it "should return same characters among two inputs" do
      b = Box.new

      expect(b.same_chars('abcde', 'axcye')).to eq('ace')
      expect(b.same_chars('abcde', 'fghij')).to eq('')
      expect(b.same_chars('fghij', 'fguij')).to eq('fgij')
    end

    it "should calculate number of characters diff in two inputs" do
      b = Box.new

      expect(b.diff_chars_count('abcde', 'axcye')).to eq(2)
      expect(b.diff_chars_count('abcde', 'fghij')).to eq(5)
      expect(b.diff_chars_count('fghij', 'fguij')).to eq(1)
    end

    it "should find similar ids" do
      inputs = %w[ abcde fghij klmno pqrst fguij axcye wvxyz ]

      b = Box.new
      expect(b.find_similar_ids(inputs)).to eq(['fghij', 'fguij'])
    end

    it "should find common characters in similar ids" do
      inputs = %w[ abcde fghij klmno pqrst fguij axcye wvxyz ]

      b = Box.new
      expect(b.common_characters_in_similar_ids(inputs)).to eq('fgij')
    end

    it "should convert input file into inputs" do
      inputs = ["abcdef", "bababc", "abbcde", "abcccd", "aabcdd", "abcdee", "ababab"]
      b = Box.new

      expect(b.input_file_to_array('./sample.txt')).to eq(inputs)
    end
  end
end
