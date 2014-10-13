class Qsort < ActiveRecord::Base
  acts_as_list
  attr_accessible :name, :position

end
