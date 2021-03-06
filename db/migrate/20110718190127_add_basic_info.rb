class AddBasicInfo < ActiveRecord::Migration
  def up
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :city, :string
    add_column :users, :state, :string
    add_column :users, :phone, :string
    add_column :users, :goal, :string
    add_column :users, :relocate, :string
    add_column :users, :desired_salary, :string
  end

  def down
    remove_column :users, :first_name, :string
    remove_column :users, :last_name, :string
    remove_column :users, :city, :string
    remove_column :users, :state, :string
    remove_column :users, :phone, :string
    remove_column :users, :goal, :string
    remove_column :users, :relocate, :string
    remove_column :users, :desired_salary, :string
  end
end
