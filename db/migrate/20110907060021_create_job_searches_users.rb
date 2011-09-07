class CreateJobSearchesUsers < ActiveRecord::Migration
  def change
    create_table :job_searches_users do |t|
      t.integer :user_id
      t.integer :job_search_id

      t.timestamps
    end
  end
end
