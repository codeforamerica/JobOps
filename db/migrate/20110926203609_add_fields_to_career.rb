class AddFieldsToCareer < ActiveRecord::Migration
  def change
    add_column :careers, :title, :string
    add_column :careers, :onet_code, :string
    add_column :careers, :api_safe_onet_code, :string
  end
end
