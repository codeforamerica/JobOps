class ChangeAgetoDobUser < ActiveRecord::Migration
  def up
    remove_column :users, :age, :integer
    add_column :users, :dob, :date
  end

  def down
    add_column :users, :age, :integer
    remove_column :users, :dob, :date
  end
end
