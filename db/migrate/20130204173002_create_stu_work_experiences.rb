class CreateStuWorkExperiences < ActiveRecord::Migration
  def change
    create_table :stu_work_experiences do |t|
      t.string :company
      t.string :position
      t.date :start_date
      t.string :end_date
      t.text :description
	    t.integer :student_profile_id

      t.timestamps
    end
  end
end
