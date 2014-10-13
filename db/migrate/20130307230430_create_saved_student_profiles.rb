class CreateSavedStudentProfiles < ActiveRecord::Migration
  def change
    create_table :saved_student_profiles do |t|
      t.integer :company_profile_id
      t.string :school_text
      t.string :year_text
      t.string :skill_text
      t.string :culture

      t.timestamps
    end
  end
end
