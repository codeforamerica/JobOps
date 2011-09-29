class AddDescriptionToIndustry < ActiveRecord::Migration
  def change
    add_column :industries, :description, :text
  end
end
