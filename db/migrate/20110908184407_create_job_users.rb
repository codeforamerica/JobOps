class CreateJobUsers < ActiveRecord::Migration
  def change
    create_table :job_users do |t|
      t.integer :job_id
      t.integer :user_id

      t.timestamps
    end
  end
end
