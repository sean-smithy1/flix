module MoviesHelper

  def format_release_date(date)
    if date
      date.to_s(:movie_release)
    else
      content_tag(:strong, 'No release date for this movie')
    end
  end

  def format_total_gross(movie)
    if movie.total_gross==nil
      content_tag(:strong, 'Not Available')
    elsif movie.flop?
      content_tag(:strong, 'Flop!')
    else
        number_to_currency(movie.total_gross)
    end
  end

  def image_for(movie)
    if movie.image_file_name.blank?
      image_tag('placeholder.png')
    else
      image_tag(movie.image_file_name)
    end
  end

end
