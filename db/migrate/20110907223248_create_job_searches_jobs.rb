class CreateJobSearchesJobs < ActiveRecord::Migration
  def change
    create_table :job_searches_jobs do |t|
      t.integer :job_search_id
      t.integer :job_id

      t.timestamps
    end
  end
end
