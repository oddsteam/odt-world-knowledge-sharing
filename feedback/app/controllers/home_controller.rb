class HomeController < ApplicationController
  def index

    @class_feedbacks = ClassFeedback.all
    @class_list = ClassDetail.all
  end
end
