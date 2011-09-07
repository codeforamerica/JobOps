class AddRelationsToJobs < ActiveRecord::Migration
  def up
    add_column :jobs, :location_id, :integer
    add_column :jobs, :company_id, :integer
    remove_column :jobs, :location
    remove_column :jobs, :company    
  end

  def down
    add_column :jobs, :location
    add_column :jobs, :company
    remove_column :jobs, :location_id
    remove_column :jobs, :company_id
  end
end