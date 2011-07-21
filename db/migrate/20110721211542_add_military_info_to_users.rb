class AddMilitaryInfoToUsers < ActiveRecord::Migration
  def change
    add_column :users, :military_status, :string
    add_column :users, :service_branch, :string
    add_column :users, :moc, :string
    add_column :users, :rank, :string
    add_column :users, :disability, :string
    add_column :users, :security_clearance, :string
  end
end
