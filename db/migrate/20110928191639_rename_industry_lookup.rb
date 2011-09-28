class RenameIndustryLookup < ActiveRecord::Migration
  def up
    remove_column :industry_lookups, :occupation
    add_column :industry_lookups, :title, :string
  end

  def down
    add_column :industry_lookups, :occupation, :string
    remove_column :industry_lookups, :title
  end
end
