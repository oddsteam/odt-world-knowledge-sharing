class CreateSkills < ActiveRecord::Migration[7.2]
  def change
    create_table :skills do |t|
      t.string :title
      t.integer :user_id

      t.timestamps
    end
  end
end
