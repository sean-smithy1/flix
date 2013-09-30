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

  it "requires a title" do
    movie = Movie.new(title: "")

    expect(movie.valid?).to be_false # populates errors
    expect(movie.errors[:title].any?).to be_true
  end

  it "requires a description" do
    movie = Movie.new(description: "")

    expect(movie.valid?).to be_false
    expect(movie.errors[:description].any?).to be_true
  end

  it "requires a released on date" do
    movie = Movie.new(released_on: "")

    expect(movie.valid?).to be_false
    expect(movie.errors[:released_on].any?).to be_true
  end

  it "requires a duration" do
    movie = Movie.new(duration: "")

    expect(movie.valid?).to be_false
    expect(movie.errors[:duration].any?).to be_true
  end

  it "requires a description over 24 characters" do
    movie = Movie.new(description: "X" * 24)

    expect(movie.valid?).to be_false
    expect(movie.errors[:description].any?).to be_true
  end

  it "accepts a $0 total gross" do
    movie = Movie.new(total_gross: 0.00)

    expect(movie.valid?).to be_false
    expect(movie.errors[:total_gross].any?).to be_false
  end

  it "accepts a positive total gross" do
    movie = Movie.new(total_gross: 10000000.00)

    expect(movie.valid?).to be_false
    expect(movie.errors[:total_gross].any?).to be_false
  end

  it "rejects a negative total gross" do
    movie = Movie.new(total_gross: -10000000.00)

    expect(movie.valid?).to be_false
    expect(movie.errors[:total_gross].any?).to be_true
  end

  it "accepts properly formatted image file names" do
    file_names = %w[e.png movie.png movie.jpg movie.gif MOVIE.GIF]
    file_names.each do |file_name|
      movie = Movie.new(image_file_name: file_name)

      expect(movie.valid?).to be_false
      expect(movie.errors[:image_file_name].any?).to be_false
    end
  end

  it "rejects improperly formatted image file names" do
    file_names = %w[movie .jpg .png .gif movie.pdf movie.doc]
    file_names.each do |file_name|
      movie = Movie.new(image_file_name: file_name)

      expect(movie.valid?).to be_false
      expect(movie.errors[:image_file_name].any?).to be_true
    end
  end

  it "accepts any rating that is in an approved list" do
    ratings = %w[G PG PG-13 R NC-17]
    ratings.each do |rating|
      movie = Movie.new(rating: rating)

      expect(movie.valid?).to be_false
      expect(movie.errors[:rating].any?).to be_false
    end
  end

  it "rejects any rating that is not in the approved list" do
    ratings = %w[R-13 R-16 R-18 R-21]
    ratings.each do |rating|
      movie = Movie.new(rating: rating)

      expect(movie.valid?).to be_false
      expect(movie.errors[:rating].any?).to be_true
    end
  end

  it "is valid with example attributes" do
    movie = Movie.new(movie_attributes)

    expect(movie.valid?).to be_true
  end
end

describe "A review" do

  it "belongs to a movie" do
    movie = Movie.create(movie_attributes)

    review = movie.reviews.new(review_attributes)

    expect(review.movie).to eq(movie)
  end

  it "with example attributes is valid" do
    review = Review.new(review_attributes)

    expect(review.valid?).to be_true
  end

  it "requires a name" do
    review = Review.new(name: "")

    expect(review.valid?).to be_false
    expect(review.errors[:name].any?).to be_true
  end

  it "requires a comment" do
    review = Review.new(comment: "")

    expect(review.valid?).to be_false
    expect(review.errors[:comment].any?).to be_true
  end

  it "requires a comment over 3 characters" do
    review = Review.new(comment: "X" * 3)

    expect(review.valid?).to be_false
    expect(review.errors[:comment].any?).to be_true
  end

  it "accepts star values of 1 through 5" do
    stars = [1, 2, 3, 4, 5]
    stars.each do |star|
      review = Review.new(stars: star)

      expect(review.valid?).to be_false
      expect(review.errors[:stars].any?).to be_false
    end
  end

  it "rejects invalid star values" do
    stars = [-1, 0, 6]
    stars.each do |star|
      review = Review.new(stars: star)

      expect(review.valid?).to be_false
      expect(review.errors[:stars].any?).to be_true
      expect(review.errors[:stars].first).to eq("must be between 1 and 5")
    end
  end

  it "has many reviews" do
    movie = Movie.new(movie_attributes)

    review1 = movie.reviews.new(review_attributes)
    review2 = movie.reviews.new(review_attributes)

    expect(movie.reviews).to include(review1)
    expect(movie.reviews).to include(review2)
  end

  it "deletes associated reviews" do
    movie = Movie.create(movie_attributes)

    movie.reviews.create(review_attributes)

    expect {
      movie.destroy
    }.to change(Review, :count).by(-1)
  end

  it "has many reviews" do
    movie = Movie.new(movie_attributes)

    review1 = movie.reviews.new(review_attributes)
    review2 = movie.reviews.new(review_attributes)

    expect(movie.reviews).to include(review1)
    expect(movie.reviews).to include(review2)
  end

  it "deletes associated reviews" do
    movie = Movie.create(movie_attributes)

    movie.reviews.create(review_attributes)

    expect {
      movie.destroy
    }.to change(Review, :count).by(-1)
  end
end
