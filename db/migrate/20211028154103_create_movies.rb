class CreateMovies < ActiveRecord::Migration[5.2]
  def change
    create_table :movies do |t|
      t.integer :code
      t.string :original_title
      t.string :original_language
      t.text :overview
      t.float :popularity
      t.float :vote_average
      t.integer :vote_count

      t.timestamps
    end
  end
end
