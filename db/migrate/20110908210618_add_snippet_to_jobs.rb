class AddSnippetToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :snippet, :text
  end
end
