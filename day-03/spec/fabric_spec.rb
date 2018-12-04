require 'fabric'

RSpec.describe Fabric do
  it "should work" do
    expect(true).to be true
  end

  it "should return squares owned by a piece of fabric" do
    f = Fabric.new

    claimed = f.claimed_squares("#123 @ 3,2: 5x4")
    expect(claimed.count).to eq(20)
    expect(claimed.first).to eq([3,2])
    expect(claimed.last).to eq([7,5])
  end

  it "should return overlapping squares" do
    f = Fabric.new

    s1 = f.claimed_squares("#1 @ 1,3: 4x4")
    s2 = f.claimed_squares("#2 @ 3,1: 4x4")
    s3 = f.claimed_squares("#3 @ 5,5: 2x2")

    expect(f.overlap([s1,s2])).to eq(4)
    expect(f.overlap([s1,s3])).to eq(0)
    expect(f.overlap([s2,s3])).to eq(0)
    expect(f.overlap([s1,s2, s3])).to eq(4)
  end

  it "should process input and return overlapping squares" do
    f = Fabric.new
    expect(f.process_overlap('./sample.txt')).to eq(4)
  end

  it "should process input and return overlapping squares" do
    f = Fabric.new
    expect(f.process_overlap('./sample2.txt')).to eq(38)
  end

  xit "should process input and return overlapping squares" do
    f = Fabric.new
    expect(f.process_overlap('./input.txt')).to eq(4)
  end
end
