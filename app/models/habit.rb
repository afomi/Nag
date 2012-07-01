class Habit < ActiveRecord::Base

  validates_uniqueness_of :description

end
