class AddRatingTrainer < ActiveRecord::Migration[7.1]
    def change
        add_column :class_feedbacks, :rating_trainer, :integer
    end
  end
  