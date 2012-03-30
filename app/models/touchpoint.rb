class Touchpoint < ActiveRecord::Base

  after_create :checkin
  after_destroy :delete_checkin

  def checkin
    msg = "Touchpoint from " + self.key + " - " + self.description
    Checkin.create!(:text => msg, :touchpoint_id => self.id)
  end

  def delete_checkin
    Checkin.where(:touchpoint_id => self.id).first.destroy
  end

end
