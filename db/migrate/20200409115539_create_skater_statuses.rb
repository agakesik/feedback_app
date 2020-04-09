class CreateSkaterStatuses < ActiveRecord::Migration[6.0]
  def change
    create_table :skater_statuses do |t|
      t.string :name

      t.timestamps
    end
  end
end
