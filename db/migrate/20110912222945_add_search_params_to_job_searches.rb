class AddSearchParamsToJobSearches < ActiveRecord::Migration
  def change
    add_column :job_searches, :search_params, :text
  end
end
