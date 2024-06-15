class ClassFeedbacksController < ApplicationController
  def new
  end

  def create
    puts params 
    puts params[:rating]
    puts params[:comment]
    c = ClassFeedback.new(rating: params[:rating], comment: params[:comment])
    c.save
  end
end
