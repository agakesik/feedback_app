class AddActivatingToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :activating, :boolean, default:false
    add_index :users, :email, unique: true, where: "activating"
  end
end
