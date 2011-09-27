class AddSafeOnetCodeToIndustryLookup < ActiveRecord::Migration
  def change
    add_column :industry_lookups, :api_safe_onet_code, :string
  end
end
