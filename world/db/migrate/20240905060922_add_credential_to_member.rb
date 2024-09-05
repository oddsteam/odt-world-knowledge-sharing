class AddCredentialToMember < ActiveRecord::Migration[7.2]
  def change
    add_column :members, :login, :string
    add_column :members, :password_digest, :string
    add_index :members, :login
  end
end
