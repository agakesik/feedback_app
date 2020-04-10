class AddRatingValueToRatings < ActiveRecord::Migration[6.0]
  def change
    add_reference :ratings, :rating_value, foreign_key: true
  end
end
