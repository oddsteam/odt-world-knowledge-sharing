class CreateEndorsements < ActiveRecord::Migration[7.2]
  def change
    create_table :endorsements do |t|
      t.integer :skill_id
      t.integer :user_id
      t.integer :endorsed_by_id

      t.timestamps
    end
  end
end
