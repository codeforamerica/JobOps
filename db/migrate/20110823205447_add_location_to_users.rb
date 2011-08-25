class AddLocationToUsers < ActiveRecord::Migration
  def change
    add_column :users, :location, :string
    remove_column :users, :city, :string
    remove_column :users, :state, :string
  end
end
