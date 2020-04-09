class AddColorToSkaterStatus < ActiveRecord::Migration[6.0]
  def change
    add_column :skater_statuses, :color, :string, default: "black"
  end
end
