class Api::ClassFeedbacksController < ApplicationController
  def index
    render json: ClassFeedback.all
  end
end
