# SEED DATA
# seeds should have enough data to make a working system that demonstrates EVERY feasible functional state of the app

checkin = {
  :text       => "Here's a check-in" + rand(1000).to_s,
  :project_id => 0
}

touchpoint = {
  :key         => ["trello", "gmail"].sample.to_s,
  :value       => "complete",
  :description => "description" + rand(1000).to_s
}

20.times do
  Checkin.create(checkin)
end

checkins = Checkin.all
20.times do
  c = checkins.sample
  Touchpoint.create(touchpoint.merge!(:checkin_id => c.id))
end
