class CreateMembers < ActiveRecord::Migration[7.2]
  def change
    create_table :members do |t|
      t.string :firstname
      t.string :lastname
      t.string :nickname
      t.string :profile_picture

      t.timestamps
    end
  end
end
