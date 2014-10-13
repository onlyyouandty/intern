class StuReference < ActiveRecord::Base
  #SETUP YOUR ACCESSIBLE ATTRIBUTES
  attr_accessible :name, :phone, :relationship, :uid, :student_profile_id, :email

  #ASSOCIATIONS  
  belongs_to :student_profile
  
  #VALIDATIONS HERE
=begin
=end
  validates :name, :relationship,
            :format => { :with => /\A[a-zA-Z\'\-\+\&\! ]*\z/,
                         :message => "Numbers and symbols are not allowed." },
            :length => { :minimum => 1,
                         :message => "This field cannot be empty" }
  validates :phone,
            :format => { :with => /\A[0-9\-\)\( ]*\z/,
                         :message => "Letters are not allowed." }
=begin
            :length => { :minimum => 1,
                         :message => "This field cannot be empty" }
=end
  validates :email,
            :format => { :with => /\A^[a-zA-Z0-9\-\.]+\@[a-zA-Z0-9\-\.]+\.(com|org|net|edu|COM|ORG|NET|EDU)$+\z/,
                         :message => "is invalid. Please enter a valid email." }  
end
