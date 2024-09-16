class UsersController < ApplicationController
  def index
  end

  def endorse_skill
    endorsement_by_me_count = Endorsement.where(user_id: params[:user_id], skill_id: params[:skill_id], endorsed_by_id: current_user.id).count
    is_endorsed_by_me = false
    if endorsement_by_me_count > 0
      Endorsement.destroy_by(user_id: params[:user_id], skill_id: params[:skill_id], endorsed_by_id: current_user.id)
    else
      endorsement = Endorsement.new(user_id: params[:user_id], skill_id: params[:skill_id], endorsed_by_id: current_user.id)
      endorsement.save
      is_endorsed_by_me = true
    end
    endorse_count = Endorsement.where(user_id: params[:user_id], skill_id: params[:skill_id]).count
    skills_user = SkillsUser.find_by(user_id: params[:user_id], skill_id: params[:skill_id])
    skills_user.endorse_count = endorse_count

    respond_to do |format|
      if skills_user.save
        @skill = Skill.find_by_id(params[:skill_id])
        format.turbo_stream {
          render turbo_stream: 
          turbo_stream.replace("skills_#{@skill.id}",
          partial: 'shared/skill',
          locals: { is_endorsed_by_me: is_endorsed_by_me, skill: @skill, skills_users_assoc: skills_user } )
        }
        format.html { redirect_to "/users/#{params[:user_id]}" }
      else
        # ... handle errors
      end
    end
  end
end
