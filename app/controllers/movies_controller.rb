class MoviesController < ApplicationController
  require 'wikipedia'
  respond_to :json, :html

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

      respond_to do |format|
        format.html { render :index }
        format.json { render json: { movie: @movie, actors: @random_actors, image: @image_results } }
      end
    end
  end
end
