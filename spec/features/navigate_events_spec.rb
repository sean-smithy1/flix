require 'spec_helper'

describe "Navigation events" do
  it "Allows navigation from the Index to the detail page" do

    movie = Movie.create(movie_attributes())

    visit movie_url(movie)
    click_link "All Movies"
    expect(current_path).to eq(movies_path)
  end

  it "Allows navigation from the detail page to the listing page" do

    movie = Movie.create(movie_attributes())

    visit movies_url
    click_link movie.title
    expect(current_path).to eq(movie_path(movie.id))
  end


end
