class HomeController < ApplicationController
  def index
    @name = "under"
    @class_feedbacks = ClassFeedback.all
  end
end
