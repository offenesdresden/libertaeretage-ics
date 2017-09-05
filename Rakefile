$:.unshift File.expand_path(File.join(File.dirname(__FILE__), 'lib'))

require 'scrape'
require 'export'

PROGRAMM_URL = "https://libertaeretage.noblogs.org/programm-2017/"
PLACES_URL = "https://libertaeretage.noblogs.org/places/"

task :default => [:convert]

task :convert do
  events = scrape(PROGRAMM_URL)
  locations = scrape_locations(PLACES_URL)
  events.each do |event|
    ls = locations.select { |l|
      l[:text].downcase.start_with?(event[:location][0..6].downcase)
    }
    if ls.empty?
      $stderr.puts "No location found for #{event[:location].inspect}"
    else
      l = ls[0]
      event[:location] = "#{l[:text]}"
      if (url = l[:url])
        event[:location] += " <#{url}>"
      end
    end
  end

  events.each do |event|
    url = event[:url]
    if url and url =~ /^https:\/\/libertaeretage.noblogs.org\//
      description = scrape_description(url)
      event[:description] = "#{description}<#{url}>"
    end
  end

  puts export(events)
end
