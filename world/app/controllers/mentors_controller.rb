class MentorsController < ApplicationController
  before_action :authenticate_user!, only: [ :index ]

  def index
    @mentors = Mentor.all
  end

  def show
    @mentor = Mentor.find(params[:id])

    Rails.logger.debug @mentor.skills

    if @mentor.nil?
      render file: "#{Rails.root}/public/404.html", layout: false, status: :not_found
    end
  end
end
