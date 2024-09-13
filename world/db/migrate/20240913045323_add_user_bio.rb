class AddUserBio < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :bio, :string, limit: 100,  default: ''
  end
end
