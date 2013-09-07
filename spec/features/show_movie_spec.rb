require 'spec_helper'

describe "A movie" do

  it "has all the page details" do
    movie = Movie.create(title: "Iron Man",
                      rating: "PG-13",
                      total_gross: 318412101.00,
                      description: "Tony Stark builds an armored suit to fight the throes of evil",
                      released_on: "2008-05-02")

    visit movie_url(movie.id)

    expect(page).to have_text(movie.title)
    expect(page).to have_text("318,412,101.00")
    expect(page).to have_text(movie.rating)
    expect(page).to have_text(movie.description)
    expect(page).to have_text("May 2, 2008")

  end
end
