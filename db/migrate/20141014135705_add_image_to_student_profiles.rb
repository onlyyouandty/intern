class AddImageToStudentProfiles < ActiveRecord::Migration
  def change
    add_column :student_profiles, :image, :string
  end
end
