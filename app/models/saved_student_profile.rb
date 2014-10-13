class SavedStudentProfile < ActiveRecord::Base
  attr_accessible :company_profile_id, :culture, :school_text, :skill_text, :year_text

  belongs_to :company_profile
end
