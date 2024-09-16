class Skill < ApplicationRecord
    has_many :skills_users
    has_many :users, through: :skills_users
  
    def endorse_count(user_id)
        self.skills_users.find_by(user_id: )
    end
end
