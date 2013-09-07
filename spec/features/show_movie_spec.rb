require 'spec_helper'

describe "A movie" do

  it "has all the page details" do
    movie = Movie.create(movie_attributes(total_gross: 10.00))

    visit movie_url(movie.id)

    expect(page).to have_text(movie.title)
    expect(page).to have_text("10.00")
    expect(page).to have_text(movie.rating)
    expect(page).to have_text(movie.description)
    expect(page).to have_text("May 2, 2008")

  end
end
