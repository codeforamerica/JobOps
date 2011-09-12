class AddJobSourceToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :job_source, :string
  end
end
