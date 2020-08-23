class CreateMovies < ActiveRecord::Migration[6.0]
  def change
    create_table :movies do |t|
      t.string :title
      t.string :rating
      t.date :release_date
      t.string :genre
      t.text :description

      t.timestamps
    end
  end
end
