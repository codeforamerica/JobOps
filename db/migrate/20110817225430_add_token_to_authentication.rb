class AddTokenToAuthentication < ActiveRecord::Migration
  def change
    add_column :authentications, :access_token, :string
    add_column :authentications, :access_secret, :string
  end
end
