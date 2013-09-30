require 'spec_helper'

describe "Creating a movie" do

  it "creates a blank form" do

    visit movies_url
    click_link ('Add New Movie')

    expect(current_path).to eq(new_movie_path)

    fill_in 'Title', with: "Updated Movie Title"
    select "PG-13", :from => "movie_rating"
    fill_in 'Total gross', with: 1234567
    fill_in 'Description', with: "AAAAAAAAAAAAAAAAAAAAA"
    fill_in "Cast", with: "The award-winning cast"
    fill_in "Director", with: "The ever-creative director"
    fill_in "Duration", with: "123 min"
    fill_in "Image file name", with: "movie.png"

    select (Time.now.year - 1).to_s, :from => "movie_released_on_1i"

    click_button "Create Movie"

    expect(current_path).to eq(movie_path(Movie.last))
    expect(page).to have_text('Updated Movie Title')
  end

  it "does not save the movie if it's invalid" do
    visit new_movie_url
     expect {
      click_button 'Create Movie'
        }.not_to change(Movie, :count)

    expect(current_path).to eq(movies_path)
    expect(page).to have_text('error')
  end

end
