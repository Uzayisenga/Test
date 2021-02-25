class CreateMovies < ActiveRecord::Migration[5.2]
  def change
    create_table :movies do |t|
      t.string :title
      t.integer :playtime
      t.string :director
      t.text :description
      t.text :poster

      t.timestamps
    end
  end
end
