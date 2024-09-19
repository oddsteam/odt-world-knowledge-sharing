class UsersController < ApplicationController
  def index
  end

  def profile_picture
    cache_key = "user_#{params[:user_id]}/profile_picture"
    Rails.cache.fetch(cache_key, expires_in: 12.hours) do
      require 'open-uri'

      @user = User.find(params[:user_id])
      if @user.profile_picture
        profile_picture = URI.open(@user.profile_picture).read
        send_data profile_picture, 
          filename: "profile_picture_#{params[:user_id]}.jpg",
          type: 'image/jpeg', 
          disposition: 'inline'
      else
        render file: "#{Rails.root}/public/404.html", layout: false, status: :not_found
      end
    end
  end

  def large_profile_picture
    cache_key = "user_#{params[:user_id]}/large_profile_picture"
    Rails.cache.fetch(cache_key, expires_in: 12.hours) do
      require 'open-uri'

      @user = User.find(params[:user_id])
      if @user.profile_picture
        profile_picture = URI.open(@user.large_profile_picture).read
        send_data profile_picture, 
          filename: "large_profile_picture_#{params[:user_id]}.jpg",
          type: 'image/jpeg', 
          disposition: 'inline'
      else
        render file: "#{Rails.root}/public/404.html", layout: false, status: :not_found
      end
    end
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
