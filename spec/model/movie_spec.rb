require 'spec_helper'

  describe "A movie" do
    it "is a flop if the total gross is < $50M" do
      movie=Movie.new(total_gross: 40000000)
      expect(movie.flop?).to be_true
  end

  it "will shoe total_gross > $50M" do
    movie=Movie.new(total_gross: 50000000)
    expect(movie.flop?).to be_false
  end

end
