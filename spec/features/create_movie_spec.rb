require 'spec_helper'

describe "Creating a movie" do
  it "creates a blank form" do

    visit movies_url
    click_link "Add Movie"

    expect(current_path).to eq(new_movie_path)

    fill_in 'Title', with: "Updated Movie Title"
    fill_in 'Rating', with: "PG-13"
    fill_in 'Total gross', with: 1234567
    fill_in 'Description', with: "AAAAAAAAAAAAAAAAAAAAA"
    select (Time.now.year - 1).to_s, :from => "movie_released_on_1i"

    click_button "Create Movie"

    expect(current_path).to eq(movie_path(Movie.last))
    expect(page).to have_text('Updated Movie Title')
  end
end
