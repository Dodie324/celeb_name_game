class Movie < ActiveRecord::Base

  def self.find(movie)
    movie_title = Movie.find_by(title: movie)

    if movie_title
      movie_title
    else
      getMovieID = Imdb::Search.new(movie)
      getMovie = Imdb::Movie.new(getMovieID.movies[0].id)
      Movie.create!(
        title:  getMovie.title,
        actors: getMovie.cast_members
      )
    end
  end
end
