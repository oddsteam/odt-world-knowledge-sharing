class ClassFeedbacksController < ApplicationController
  def new
    @class_feedback = ClassFeedback.new
  end

  def create
    puts params
    puts params[:rating]
    puts params[:comment]
    class_feedback_params = params.require(:class_feedback).permit(:rating, :comment, :class_detail_id)
    @class_feedback = ClassFeedback.new(class_feedback_params)
    respond_to do |format|
      if @class_feedback.save
        format.turbo_stream
        format.html do
          redirect_to home_index_path
        end
      end
    end
  end
end
