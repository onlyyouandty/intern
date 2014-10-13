class CompanyProfile < ActiveRecord::Base
  #SETUP YOUR ACCESSIBLE ATTRIBUTES
  attr_accessible :company_name, :company_type, :description, :number_of_employees, :qsort, :user_id, :website, :email, :location, :tax_code, :verified

  #ASSOCIATIONS
  has_one :user, :as => :profileable
  has_many :job_postings
  has_many :saved_student_profiles

  #VALIDATIONS HERE
=begin
=end
  validates :company_name, :company_type,
            :format => { :with => /\A[a-zA-Z\'\-\,\!\.\&\(\)\@\#\$\%\" ]*\z/,
                         :message => "Numbers are not allowed." },
            :length => { :minimum => 1,
                         :message => "This field cannot be empty" }
  validates :location,
            :format => { :with => /\A[a-zA-Z\,\.\- ]*\z/,
                         :message => "Numbers and symbols are not allowed." },
            :length => { :minimum => 1,
                         :message => "This field cannot be empty" }
  validates :description,
            :length => { :maximum => 300,
                         :message => "Over 300 characters" }
  validates :number_of_employees,
            :numericality => { :only_integer => true }


  validates :website,
            :format => { :with => /\A^(http:\/\/){1}[a-zA-Z0-9\-\.]+\.(com|org|net|edu|COM|ORG|NET|EDU)${1}\z/,
                         :message => "is invalid. Must begin with http:// and end in .com, .org, .net, or .edu." }
  validates :tax_code,
            :format => { :with => /\A[a-zA-Z0-9]*\z/,
                         :message => "Symbols are not allowed." },
            :length => { :minimum => 1,
                         :message => "This field cannot be empty" }

end
