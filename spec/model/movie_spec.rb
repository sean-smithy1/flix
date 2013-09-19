require 'spec_helper'
describe "A movie" do

  it "is a flop if the total gross is < $50M" do
    movie=Movie.new(total_gross: 40000000)
    expect(movie.flop?).to be_true
  end

  it "will show total_gross > $50M" do
    movie=Movie.new(total_gross: 50000000)
    expect(movie.flop?).to be_false
  end

  it "is released when the released on date is in the past" do
    movie = Movie.create(movie_attributes(released_on: 3.months.ago))

    expect(Movie.released).to include(movie)
  end

  it "is not released when the released on date is in the future" do
    movie = Movie.create(movie_attributes(released_on: 3.months.from_now))

    expect(Movie.released).not_to include(movie)
  end

  it "returns released movies ordered with the most recently-released movie first" do
    movie1 = Movie.create(movie_attributes(released_on: 3.months.ago))
    movie2 = Movie.create(movie_attributes(released_on: 2.months.ago))
    movie3 = Movie.create(movie_attributes(released_on: 1.months.ago))

    expect(Movie.released).to eq([movie3, movie2, movie1])
  end
end
