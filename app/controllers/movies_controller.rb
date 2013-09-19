class MoviesController < ApplicationController

  def index
    @movies=Movie.current
  end

  def show
    @movie=Movie.find(params[:id])
  end

  def edit
    @movie=Movie.find(params[:id])
  end

  def update
  # No need to use a @ as it's not used in the form, maybe safer?
    movie=Movie.find(params[:id])
    if movie.update(movie_params)
      flash[:notice] = "Movie successfully updated"
    end
    redirect_to movie
  end

  def new
    @movie=Movie.new
  end

  def create
    @movie=Movie.new(movie_params)
    @movie.save
    redirect_to @movie
  end

  def destroy
    movie = Movie.find(params[:id])
    movie.destroy
    redirect_to movies_path
  end


private
  def movie_params
    params.require(:movie).permit(:title, :description, :rating, :released_on, :total_gross)
  end

end
