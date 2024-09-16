class AddEndorsementCountCache < ActiveRecord::Migration[7.2]
  def change
    add_column :skills_users, :endorse_count, :integer, null: false, default: 0
  end
end
