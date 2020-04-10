class CreateRatingValues < ActiveRecord::Migration[6.0]
  def change
    create_table :rating_values do |t|
      t.integer :value, unique: true
      t.string :name, unique: true
      t.string :color, default: "white"

      t.timestamps
    end
  end
end
