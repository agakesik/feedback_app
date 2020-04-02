class CreateRatings < ActiveRecord::Migration[6.0]
  def change
    create_table :ratings do |t|
      t.integer :value
      t.references :user
      t.references :skill

      t.timestamps
    end
    add_index :ratings, [:user_id, :skill_id, :created_at]
  end
end
