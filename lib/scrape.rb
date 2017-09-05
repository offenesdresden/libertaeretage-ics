# coding: utf-8
require 'nokogiri'
require 'open-uri'

def scrape(url)
  doc = Nokogiri::HTML(open(url).read)
  month = nil
  day = nil
  events = []

  doc.css('.entry-content p').each do |p|
    text = p.content.gsub(/\n/, "")
    if text =~ /\((\d+)\.(\d+)\)/
      # puts "## 2017-#{$2}-#{$1} ##"
      month = $2.to_i
      day = $1.to_i
    elsif text =~ /(?u)(\d+):(\d+)[\s––]+(\d+):(\d+)[\s–]+(.+?)\s+@\s+(.+)/
      a = p.search('a')
      href = not(a.empty?) ? a.attribute('href').value : nil

      # puts "* #{$1}:#{$2}-#{$3}:#{$4} [#{$6}]"
      # puts "  #{$5}"
      # puts "  <#{href}>"
      event = {
        :start => DateTime.new(2017, month, day, $1.to_i, $2.to_i, 0),
        :end => DateTime.new(2017, month, day, $3.to_i, $4.to_i, 0),
        :location => $6,
        :url => href,
        :summary => $5
      }
      events << event
    else
      $stderr.puts "Unrecognized: #{text.inspect}"
    end
  end

  events
end

def scrape_locations(url)
  locations = []
  doc = Nokogiri::HTML(open(url).read)
  doc.css('.entry-content li').each do |li|
    text = li.content.gsub(/\n/, "")
    a = li.search('a')
    href = not(a.empty?) ? a.attribute('href').value : nil

    locations << {
      :text => text,
      :url => href
    }
  end
  locations
end

def scrape_description(url)
  text = ""
  doc = Nokogiri::HTML(open(url).read)
  doc.css('.entry-content p').each do |p|
    text << p.content.gsub(/\n/, "")
    text << "\n\n"
  end
  text
end
