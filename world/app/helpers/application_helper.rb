module ApplicationHelper
    def is_endorsed_by_me(skills_users_assoc)
        user_signed_in? && !!Endorsement.find_by(skill_id: skills_users_assoc.skill_id, endorsed_by_id: current_user.id)
    end
end