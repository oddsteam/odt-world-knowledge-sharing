class AddRecommendFeedback < ActiveRecord::Migration[7.1]
  def change
    add_column :class_feedbacks, :recommend, :boolean
  end
end
