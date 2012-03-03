class Checkin < ActiveRecord::Base

  def self.hundred_latest
    Checkin.all(:limit => 100, :order => "created_at DESC")
  end
end
