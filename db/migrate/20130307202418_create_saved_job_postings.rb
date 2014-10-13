class CreateSavedJobPostings < ActiveRecord::Migration
  def change
    create_table :saved_job_postings do |t|
      t.string :position_text
      t.string :description_text
      t.string :paid_text
      t.string :requirements_text
      t.string :culture
      t.integer :student_profile_id

      t.timestamps
    end
  end
end
