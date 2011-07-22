class CreateWars < ActiveRecord::Migration
  def change
    create_table :wars do |t|
      t.string :war
      t.integer :user_id

      t.timestamps
    end
  end
end
