class AddIsMentorToUser < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :is_mentor, :boolean, default: false
    add_index :users, :is_mentor
  end
end
