class ReviewsController < ApplicationController
  before_action :find_movie
	before_action :find_review, only: [:edit, :update, :destroy]
	before_action :authenticate_user!, only: [:new, :edit]

	def new
    if current_user
    @review = Review.where(user_id: current_user.id, movie_id: params[:movie_id]).first_or_initialize
    if @review.id.present?
      render 'edit'
    end 
  end
	end

	def create
		@review = Review.new(review_params)
		@review.movie_id = @movie.id
		@review.user_id = current_user.id

		if @review.save
			redirect_to movie_path(@movie)
		else
			render 'new'
		end
	end

	def edit
	end

	def update
		if @review.update(review_params)
			redirect_to movie_path(@movie)
		else
			render 'edit'
		end
	end

	def destroy
		@review.destroy
		redirect_to movie_path(@movie)
	end

	private

		def review_params
			params.require(:review).permit(:rating, :comment)
		end

		def find_movie
			@movie = Movie.find(params[:movie_id])
		end

		def find_review
			@review = Review.find(params[:id])
		end
end
