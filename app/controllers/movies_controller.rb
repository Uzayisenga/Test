class MoviesController < ApplicationController
  before_action :find_movie, only: [:show, :edit, :update, :destroy]

  def index

    if params[:genre].blank?
			@movies = Movie.all.order('created_at DESC')
		else
			@genre_id = Genre.find_by(name: params[:genre]).id
			@movies = Movie.where(:genre_id => @genre_id).order("created_at DESC")
		end
  end

  def show
  end

  def new
    @movie = current_user.movies.build
    @genres = Genre.all.map{ |c| [c.name, c.id]}
  end

  def edit
    @genres = Genre.all.map{ |c| [c.name, c.id] }
  end

  def create
    @movie = current_user.movies.build(movie_params)
    @movie.genre_id = params[:genre_id]
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
    @movie.genre_id = params[:genre_id]
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
