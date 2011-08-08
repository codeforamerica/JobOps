class AddSettingsToUser < ActiveRecord::Migration
  def change
    add_column :users, :privacy_settings, :text
    add_column :users, :email_settings, :text
  end
end
