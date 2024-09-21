class MeController < ApplicationController
  before_action :authenticate_user!, only: [:index]

  def index
    @me = User.find(current_user.id)
  end

  def opt_mentor
    @me = User.find(current_user.id)
    @me.is_mentor = !@me.is_mentor

    respond_to do |format|
      if @me.save
        format.turbo_stream {
          render turbo_stream: 
          turbo_stream.replace("opt_mentor",
          partial: 'shared/opt_mentor',
          locals: { is_mentor: @me.is_mentor } )
        }
        format.html { redirect_to "/me" }
      else
      end
    end
  end

  def update_bio
    @me = User.find(current_user.id)
    @me.bio = params[:bio]

    respond_to do |format|
      if @me.save
        format.turbo_stream {
          render turbo_stream: 
          turbo_stream.replace("me_bio",
          partial: 'shared/me_bio',
          locals: { text: @me.bio } )
        }
        format.html { redirect_to "/me" }
      else
      end
    end
  end
end
