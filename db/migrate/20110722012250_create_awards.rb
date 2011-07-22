class CreateAwards < ActiveRecord::Migration
  def change
    create_table :awards do |t|
      t.string :award
      t.date :award_date
      t.integer :user_id

      t.timestamps
    end
  end
end
