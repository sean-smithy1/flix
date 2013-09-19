class Movie < ActiveRecord::Base

  def flop?
    total_gross < 50000000
  end

  def self.current
    where('released_on <= ?', Time.now).order('released_on desc')
  end

end
