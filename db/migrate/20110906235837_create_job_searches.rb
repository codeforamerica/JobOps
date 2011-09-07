class CreateJobSearches < ActiveRecord::Migration
  def change
    create_table :job_searches do |t|
      t.string :keyword
      t.string :location
      t.float :lat
      t.float :long
      t.integer :user_id
      t.boolean :user_saved

      t.timestamps
    end
  end
end
