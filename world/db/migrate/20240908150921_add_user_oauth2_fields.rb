class AddUserOauth2Fields < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :provider, :string, limit: 50,  default: ''
    add_column :users, :uid,      :string, limit: 500, default: ''
  end
end
