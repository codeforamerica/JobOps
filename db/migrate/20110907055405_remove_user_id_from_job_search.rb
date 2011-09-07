class RemoveUserIdFromJobSearch < ActiveRecord::Migration
  def up
    remove_column :job_searches, :user_id
  end

  def down
    add_column :job_searches, :user_id
  end
end
