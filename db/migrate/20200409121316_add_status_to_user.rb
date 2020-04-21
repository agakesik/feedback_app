class AddStatusToUser < ActiveRecord::Migration[6.0]
  def change
    add_reference :users, :skater_status, foreign_key: true
  end
end
