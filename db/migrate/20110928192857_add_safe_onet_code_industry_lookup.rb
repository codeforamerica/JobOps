class AddSafeOnetCodeIndustryLookup < ActiveRecord::Migration
  def up
    remove_column :industry_lookups, :api_safe_onet_code
    add_column :industry_lookups, :api_safe_onet_soc_code, :string
  end

  def down
    remove_column :industry_lookups, :api_safe_onet_soc_code
    add_column :industry_lookups, :api_safe_onet_code, :string
  end
end
