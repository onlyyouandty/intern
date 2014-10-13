class CreateStuReferences < ActiveRecord::Migration
  def change
    create_table :stu_references do |t|
      t.string :uid
      t.string :name
      t.string :relationship
      t.string :phone
	    t.integer :student_profile_id
      t.string :email

      t.timestamps
    end
  end
end
