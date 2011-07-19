class CreateJobHistories < ActiveRecord::Migration
  def change
    create_table :job_histories do |t|
      t.string :org_name
      t.string :title
      t.date :start_date
      t.date :end_date
      t.text :summary

      t.timestamps
    end
  end
end
