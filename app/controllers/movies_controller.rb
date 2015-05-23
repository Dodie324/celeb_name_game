class MoviesController < ApplicationController
  def index
    @image_results = []
    if params[:title]
      @movie = Movie.find(params[:title])
      @random_actors = JSON.parse(@movie.actors)[0...5]

      @random_actors.each do |actor|
        if Google::Search::Image.new(query: actor).first.uri.empty?
          @image_results << Google::Search::Image.new(query: actor).second.uri
        else
          @image_results << Google::Search::Image.new(query: actor).first.uri
        end
      end

      @image_results
    end
  end
end
