class MeController < ApplicationController
  before_action :authenticate_user!, only: [:index]

  def index
    @me = User.find(current_user.id)
  end

  def show_calendar
    calendar_month = params[:calendar]
    @calendar = CalendarService.new().create_calendar_data(calendar_month)

    respond_to do |format|
      format.turbo_stream {
        render turbo_stream: 
        turbo_stream.replace("mentor_calendar",
        partial: 'shared/availability_calendar',
        locals: { calendar: @calendar } )
      }
      format.html { redirect_to "/users/me/mentor/availability" }
    end
  end

  def show_mentor_availability
    calendar_month = params.fetch(:calendar, "")
    @calendar = CalendarService.new().create_calendar_data(calendar_month)
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
                partial: 'shared/opt_mentor',
                locals: { is_mentor: @me.is_mentor }),
            turbo_stream.replace("mentor_availability",
                partial: 'shared/mentor_availability_link',
                locals: { is_mentor: @me.is_mentor }),
            turbo_stream.replace("my_mentor_status",
                partial: 'me/my_mentor_status',
                locals: { is_mentor: @me.is_mentor })
          ]
        end
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
