require 'spec_helper'

describe MoviesController do
  describe "Business Rule Flop" do

    it "returns flop for total_gross values < $5,000,000" do
      movie = Movie.create(total_gross: 4999999)
      expect(movie.flop?).to eq true
    end

    it "returns a value for total_gross values >= $50,000,000" do
      movie = Movie.create(total_gross: 50000000)
      expect(movie.flop?).to eq false
    end

  end
end
