class AddResumeToUser < ActiveRecord::Migration
  def change
    add_column :users, :resume, :text
  end
end
