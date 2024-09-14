class FixSkillRelation < ActiveRecord::Migration[7.2]
  def change
    drop_table :user_skills

    create_table :user_skills do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :skill, null: false, foreign_key: true
      t.timestamps
    end
  end
end
