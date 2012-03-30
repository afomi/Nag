class Touchpoint < ActiveRecord::Base

  after_create :checkin

  def checkin
    msg = "Touchpoint from " + self.key + " - " + self.description
    Checkin.create!(:text => msg)
  end

end
