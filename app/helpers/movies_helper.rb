module MoviesHelper

  def format_release_date(date)
    if date then
      date.to_s(:long)
    else
      'No release date for this movie'
    end
  end


end
