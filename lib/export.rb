# coding: utf-8
require 'icalendar'
require 'icalendar/tzinfo'

TIMEZONE = "Europe/Berlin"

def export(events)
  cal = Icalendar::Calendar.new
  events.each do |event|
    cal.event do |e|
      e.summary = event[:summary]
      e.url = event[:url]
      e.location = event[:location]
      e.dtstart = Icalendar::Values::DateTime.new(event[:start], 'tzid' => TIMEZONE)
      e.dtend = Icalendar::Values::DateTime.new(event[:end], 'tzid' => TIMEZONE)
      e.organizer = Icalendar::Values::CalAddress.new("mailto:libtage2016@riseup.net", cn: "Libertäre Tage Dresden")
    end
  end

  cal.publish
  cal.to_ical
end
