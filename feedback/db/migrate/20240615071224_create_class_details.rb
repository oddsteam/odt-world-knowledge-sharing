class CreateClassDetails < ActiveRecord::Migration[7.1]
  def change
    create_table :class_details do |t|
      t.text :name

      t.timestamps
    end
  end
end
