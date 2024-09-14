class NormalizeSkills < ActiveRecord::Migration[7.2]
  def change
    remove_column :skills, :user_id

    create_table :user_skills do |t|
      t.references :user, null: false, foreign_key: true
      t.references :skill, null: false, foreign_key: true
      t.timestamps
    end
  end
end
