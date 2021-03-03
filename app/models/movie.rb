class Movie < ApplicationRecord
  belongs_to :user
  belongs_to :genre
  has_many :reviews
  searchkick
  enum status: [:pending, :published]
  def search_data
    {
      title: title,
      director: director,
      description: description,
    }
  end
  paginates_per 2
  has_attached_file :movie_img, styles: { movie_index: "250x350>", movie_show: "325x475>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :movie_img, content_type: /\Aimage\/.*\z/
end
