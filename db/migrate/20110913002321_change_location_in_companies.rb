class ChangeLocationInCompanies < ActiveRecord::Migration
  def up
    add_column :companies, :lat, :float
    add_column :companies, :long, :float    
  end

  def down
    remove_column :companies, :lat
    remove_column :companies, :long  
  end
end