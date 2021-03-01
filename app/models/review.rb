class Review < ApplicationRecord
  belongs_to :movie
  belongs_to :user, inverse_of: :reviews
  validates_uniqueness_of :user_id, :scope => :movie_id, :message=>"You can't review a product more than once", on: 'create'

end
