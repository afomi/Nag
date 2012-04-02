# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

@checkin = Checkin.create!(
    :text       => "Here's a check-in",
    :project_id => 0
)

@touchpoint = Touchpoint.create!(
    :key         => "trello",
    :value       => "complete",
    :description => "description",
    :project_id  => 0,
    :checkin_id  => @checkin.id

)