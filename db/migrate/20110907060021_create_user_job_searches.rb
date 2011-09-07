class CreateUserJobSearches < ActiveRecord::Migration
  def change
    create_table :user_job_searches do |t|
      t.integer :user_id
      t.integer :job_searches_id

      t.timestamps
    end
  end
end
