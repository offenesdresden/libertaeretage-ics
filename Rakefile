$:.unshift File.expand_path(File.join(File.dirname(__FILE__), 'lib'))

require 'scrape'
require 'export'

PROGRAMM_URL = "https://libertaeretage.noblogs.org/programm-2017/"

task :default => [:convert]

task :convert do
  events = scrape(PROGRAMM_URL)
  puts export(events)
end
