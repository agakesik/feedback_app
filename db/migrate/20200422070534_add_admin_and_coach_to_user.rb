class AddAdminAndCoachToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :admin, :boolean, default: false
    add_column :users, :coach, :boolean, default: false
    add_index :users, [:admin, :coach]
  end
end
