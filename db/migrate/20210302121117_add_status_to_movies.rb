class AddStatusToMovies < ActiveRecord::Migration[5.2]
  def change
    add_column :movies, :status, :integer, default:0
  end
end
