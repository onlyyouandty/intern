class CreateSkills < ActiveRecord::Migration
  def change
    create_table :skills do |t|
      t.string :user_id
      t.string :description
	    t.integer :student_profile_id

      t.timestamps
    end
  end
end
