class CreateEducations < ActiveRecord::Migration
  def change
    create_table :educations do |t|
      t.string :school_name
      t.string :degree
      t.string :study_field
      t.date :start_date
      t.date :end_date
      t.text :activities
      t.text :notes

      t.timestamps
    end
  end
end
