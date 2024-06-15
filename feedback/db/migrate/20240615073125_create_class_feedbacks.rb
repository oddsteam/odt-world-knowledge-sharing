class CreateClassFeedbacks < ActiveRecord::Migration[7.1]
  def change
    create_table :class_feedbacks do |t|
      t.integer :rating
      t.text :comment
      t.references :class_detail, null: false, foreign_key: true

      t.timestamps
    end
  end
end
