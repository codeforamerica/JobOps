class AdduseridtoJobHistory < ActiveRecord::Migration
  def change
    add_column :job_histories, :user_id, :integer
  end
end
