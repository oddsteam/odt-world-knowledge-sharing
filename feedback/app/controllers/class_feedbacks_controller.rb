class ClassFeedbacksController < ApplicationController
  def new
    @class_feedback = ClassFeedback.new
    @class_feedback.class_detail_id = params[:class_id]
  end

  def create
    puts params
    puts params[:rating]
    puts params[:comment]
    puts params[:recommend]
    class_feedback_params = params.require(:class_feedback).permit(:rating , :recommend, :comment, :class_detail_id)
    @class_feedback = ClassFeedback.new(class_feedback_params)
    # respond_to do |format|
    if @class_feedback.save
      # format.turbo_stream
      # format.html do
        # render "thank/thank_you"
        redirect_to thank_you_path
      # end
    end
    # end
  end
end
