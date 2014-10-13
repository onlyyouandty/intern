class CreateStudentProfiles < ActiveRecord::Migration
  def change
    create_table :student_profiles do |t|
      t.string :first_name
      t.string :last_name
      t.string :user_id
      t.string :school
      t.string :email
      t.string :expected_graduation
      t.string :school_year
      t.string :last_completed_degree
      t.string :zip
      t.string :qsort
      t.string :major
      t.string :resume
      t.timestamps
    end
  end
end
