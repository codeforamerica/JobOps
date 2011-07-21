class CreateCertifications < ActiveRecord::Migration
  def change
    create_table :certifications do |t|
      t.string :name
      t.string :institution
      t.date :date_acquired
      t.integer :user_id

      t.timestamps
    end
  end
end
