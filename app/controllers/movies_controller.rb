class MoviesController < ApplicationController
  load_and_authorize_resource
  before_action :find_movie, only: [:show, :edit, :update, :destroy]
  before_action :set_select_collections, only: [:edit, :new, :create]
  before_action :authenticate_user!, only: [:edit, :new, :create]
  PER = 1

  def index
    search = params[:term].present? ? params[:term] : nil
    @movies = if search
      Movie.search(search)
    elsif params[:genre].blank?
			@movies = Movie.all.order('created_at DESC')
		else
			@genre_id = Genre.find_by(name: params[:genre]).id
			@movies = Movie.where(:genre_id => @genre_id).order("created_at DESC")
		end
  end

  def approve
  if can? :approve, Movie
    @movie.update_attributes approved: true
  end
end

  def show
    if @movie.reviews.blank?
			@average_review = 0
		else
			@average_review = @movie.reviews.average(:rating).round(2)
		end
  end

  def new
    @movie = current_user.movies.build
  end

  def edit
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
    def set_select_collections
      @genres = Genre.all.map{ |c| [c.name, c.id] }
    end

    def movie_params
      params.require(:movie).permit(:title, :playtime, :director, :description, :movie_img)
    end
end
