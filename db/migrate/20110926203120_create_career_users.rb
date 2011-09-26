class CreateCareerUsers < ActiveRecord::Migration
  def change
    create_table :career_users do |t|
      t.integer :career_id
      t.integer :user_id

      t.timestamps
    end
  end
end
