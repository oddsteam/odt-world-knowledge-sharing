class MentorsController < ApplicationController
  before_action :authenticate_user!, only: [ :index ]

  def index
    @mentors = Mentor.all
  end
end
