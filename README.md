## About Nag

Nag is a web-application designed to prompt me at periodic intervals
to ensure I am making progress on items.  It is a personal micro-blogging tool.

It should be lightweight, easy, and useful.

At the end of the day, it will show me what I've done, and maybe someday
it can help me prioritize.

### User Experience

Every 25 minutes, ask me what I've been doing since whatever I was doing since last checkin.

## Stack

* Rails 3.2.17
* SQLite or MySQL
* JQuery 1.11.1
* Twitter Bootstrap 2.3.2

## Setup

* git clone https://github.com/afomi/Nag.git nag
* cd nag
* bundle install
* update /database.yml
* specify custom settings to /config/settings.rb

Optionally, enable google calendar feed

    in /config/initializers/settings.rb
    $google_calendar_1 = ""                # find the Google Calendar XML in the Calendar Details Page
    $google_calendar_2 = ""

#### Author

* Ryan Wold, [afomi.com](http://afomi.com)
