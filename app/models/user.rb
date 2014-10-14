class User < ActiveRecord::Base
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :profileable_id, :profileable_type, :user_type, :terms

  #ASSOCIATIONS
   belongs_to :profileable, :polymorphic => true

  #DEVISE STUFF
  # Include default devise modules. Others available are:
  #   :confirmable, :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :lockable, :timeoutable

  #The different user types defined in an array the %w[admin student profile] is ruby shorthand for ["admin", "student", "company"]
  USER_TYPES = %w[student company]

  validates_acceptance_of :terms
end
