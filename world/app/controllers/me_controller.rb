class MeController < ApplicationController
  def index
    @me = User.find(current_user.id)
  end

  def opt_mentor
    @me = User.find(current_user.id)
    @me.is_mentor = !@me.is_mentor
    @me.save

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
end
