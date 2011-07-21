class CreateTrainings < ActiveRecord::Migration
  def change
    create_table :trainings do |t|
      t.string :training
      t.date :training_date
      t.integer :user_id

      t.timestamps
    end
  end
end
