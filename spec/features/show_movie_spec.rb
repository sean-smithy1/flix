require 'spec_helper'

describe "A movie" do

  it "has all the page details" do
    movie = Movie.create(movie_attributes())

    visit movie_url(movie.id)

    expect(page).to have_text(movie.title)
    expect(page).to have_text(movie.rating)
    expect(page).to have_text(movie.description)
    expect(page).to have_text("May 2, 2008")
  end

    it "shows the total gross if the total gross > $50M" do
      movie = Movie.create(movie_attributes(total_gross: 60000000))
      visit movie_url(movie)
      expect(page).to have_text("$60,000,000")
    end

    it "shows 'Flop!' if the total gross < $50M" do
      movie = Movie.create(movie_attributes(total_gross: 49999999))
      visit movie_url(movie)
      expect(page).to have_text("Flop!")
    end

end
