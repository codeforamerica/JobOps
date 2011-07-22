class AddUnitToUsers < ActiveRecord::Migration
  def change
    add_column :users, :unit, :string
  end
end
