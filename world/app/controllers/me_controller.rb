class MeController < ApplicationController
  before_action :authenticate_user!, only: [:index]

  def index
    @me = User.find(current_user.id)
  end

  def show_mentor_availability
  end

  def show_mentor_availability_date
    @selected_date = {
      wday: Date.new(params[:year].to_i, params[:month].to_i, params[:date].to_i).wday,
      date: params[:date],
      month: params[:month],
      year: params[:year]
    }

    respond_to do |format|
      format.turbo_stream {
        render turbo_stream:
        turbo_stream
          .replace("available_date",
          partial: "mentor_available_date",
          locals: { selected_date: @selected_date })
      }
      format.html { redirect_to "/users/me" }
    end
  end

  def opt_mentor
    @me = User.find(current_user.id)
    @me.is_mentor = !@me.is_mentor

    respond_to do |format|
      if @me.save
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream
              .replace("opt_mentor",
                partial: 'mentor_opt_in_button',
                locals: { is_mentor: @me.is_mentor }),
            turbo_stream.replace("mentor_availability",
                partial: 'shared/mentor_availability_link',
                locals: { is_mentor: @me.is_mentor }),
            turbo_stream.replace("my_mentor_status",
                partial: 'me/my_mentor_status',
                locals: { is_mentor: @me.is_mentor })
          ]
        end
        format.html { redirect_to "/users/me" }
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
          partial: 'editable_bio',
          locals: { text: @me.bio } )
        }
        format.html { redirect_to "/users/me" }
      else
      end
    end
  end
end
