class Api::CoursesRatingController < ApplicationController
    def index
        courses_rating = ClassFeedback
        .select(:class_detail_id, 'ROUND( AVG(rating), 2 ) AS average_rating')
        .group(:class_detail_id)

        render json: (courses_rating), except: ['id']
    end
end
