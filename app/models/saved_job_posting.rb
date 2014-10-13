class SavedJobPosting < ActiveRecord::Base
  attr_accessible :culture, :description_text, :paid_text, :position_text, :requirements_text, :student_profile_id

  belongs_to :student_profile
end
