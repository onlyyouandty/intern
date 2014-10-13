class Skill < ActiveRecord::Base
  #SET ACCESSIBLE ATTRIBUTES HERE
  attr_accessible :description, :user_id, :student_profile_id

  #ASSOCIATIONS
    belongs_to :student_profile

  #VALIDATIONS HERE
=begin  
=end
  validates :description,
            :length => { :minimum => 1,
                         :message => "This field cannot be empty" }
  validates :description,
            :length => { :maximum => 32,
                         :message => "Too long." }
  validates_uniqueness_of :description, :scope => :student_profile_id, :case_sensitive => false

end
