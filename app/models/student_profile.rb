class StudentProfile < ActiveRecord::Base
  #SET UP ACCESSIBLE ATTRIBUTES HERE
  attr_accessible :email, :expected_graduation, :first_name, :last_completed_degree, :last_name, :school,
                  :school_year, :user_id, :zip, :qsort, :major, :resume

  #ASSOCIATIONS
  has_one :user, :as => :profileable
  has_many :stu_work_experiences
  has_many :skills
  has_many :stu_references
  has_many :saved_job_postings

  #Used for file uploading
  mount_uploader :resume, ResumeUploader

  #VALIDATIONS HERE
=begin
=end
    validates :first_name, :last_name, :last_completed_degree, :school,
              :format => { :with => /\A[a-zA-Z\'\- ]*\z/,
                           :message => "Numbers and symbols are not allowed." },
              :length => { :minimum => 1,
                           :message => "This field cannot be empty" }
    validates :zip,
              :numericality => { :only_integer => true },
              :length => { :is => 5,
                           :message => "Please enter a proper zip code." }

end
