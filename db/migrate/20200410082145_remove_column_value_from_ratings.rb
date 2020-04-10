class RemoveColumnValueFromRatings < ActiveRecord::Migration[6.0]
  def change
    remove_column :ratings, :value
  end
end
