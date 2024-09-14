class FixUserSkillAssocName < ActiveRecord::Migration[7.2]
  def change
    rename_table :user_skills, :skills_users
  end
end
