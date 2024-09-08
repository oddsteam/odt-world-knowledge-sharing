class RenameMemberToUser < ActiveRecord::Migration[7.2]
  def change
    rename_table :members, :users
  end
end
