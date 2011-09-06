class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :company
      t.date :date_acquired
      t.string :location
      t.string :title
      t.string :url

      t.timestamps
    end
  end
end
