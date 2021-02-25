class MoviesController < ApplicationController
  before_action :find_movie, only: [:show, :edit, :update, :destroy]

  def index
    @movies = Movie.all
  end

  def show
  end

  def new
    @movie = Movie.new
  end

  def edit
  end

  def create
    @movie = Movie.new(movie_params)
    if params[:back]
      render :new
    else
      if @movie.save
        redirect_to movies_path, notice: "Movie posted for review"
      else
        render :new
      end
    end
  end

  def confirm
    @movie = Movie.new(movie_params)
  end

  def update
		if @movie.update(movie_params)
			redirect_to movie_path(@movie)
		else
			render 'edit'
		end
  end

  def destroy
    @movie.destroy
		redirect_to root_path
  end

  private
    def find_movie
      @movie = Movie.find(params[:id])
    end

    def movie_params
      params.require(:movie).permit(:title, :playtime, :director, :description, :movie_img)
    end
end
