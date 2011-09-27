class CreateIndustryLookups < ActiveRecord::Migration
  def change
    create_table :industry_lookups do |t|
      t.integer :industry_id
      t.string :onet_code
      t.string :occupation

      t.timestamps
    end
  end
end
