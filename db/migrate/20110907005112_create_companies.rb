class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name
      t.string :location
      t.integer :linkedin_id

      t.timestamps
    end
  end
end
