class MoviesController < ApplicationController
  require 'wikipedia'

  def index
    @image_results = []
    @wikipedia = []
    if params[:title]
      @movie = Movie.find(params[:title])
      @random_actors = JSON.parse(@movie.actors)[0...5].shuffle

      @random_actors.each do |actor|
        page = Wikipedia.find(actor)
        if page.image_urls.first
          @image_results << page.image_urls.first
        else
          @image_results << Google::Search::Image.new(query: actor).first.uri
        end
      end

      @image_results
    end
  end
end
