class SummarizeFeedbackController < ApplicationController
    def summarize_feedback
      logger.debug params[:class_detail_id].class

      @class_feedback = ClassFeedback
        .where(class_detail_id: params[:class_detail_id])
        .order(params[:sort])
        .reverse
      @class_detail = ClassDetail
      @record_count = ClassFeedback
        .where(class_detail_id: params[:class_detail_id])
        .select(:class_detail_id)
        .count
      @courses_rating = ClassFeedback
      .select(:class_detail_id, 'ROUND( AVG(rating), 2 ) AS average_rating')
      .group(:class_detail_id)
      .having(class_detail_id: params[:class_detail_id])
      .first
      
      @recommend = ClassFeedback
      .where(class_detail_id: params[:class_detail_id])
      .group(:recommend)
      .count[true]/@record_count.to_f*100

      @trainer_rating = ClassFeedback
      .select(:class_detail_id, 'ROUND( AVG(rating_trainer), 2 ) AS average_trainer_rating')
      .first

  



  
  


  
    
      

    
    end
  end
  