class AddStatusToUser < ActiveRecord::Migration[6.0]
  def change
    add_reference :users, :skater_status, default: 1, null: false, foreign_key: true
  end
end