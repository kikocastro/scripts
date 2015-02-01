#!/usr/bin/env ruby

# to execute script, define rvm alias: http://notes.jerzygangi.com/creating-a-ruby-launchd-task-with-rvm-in-os-x/

require 'mechanize'

mechanize = Mechanize.new

site = "http://www.accuweather.com/en/us/new-paltz-ny/12561/weather-forecast/339712"
page = mechanize.get(site)

todayInfo = page.at("#feed-main")

condition = todayInfo.search(".cond").text
temperature = todayInfo.search(".temp").text.scan(/\d+/).first.to_i 
realFeel = todayInfo.search(".realfeel").text.scan(/\d+/).first.to_i 

temperatureCelsius = ((temperature - 32)/1.8).round
realFeelCelsius = ((realFeel - 32)/1.8).round

msg = %Q{terminal-notifier -message " " -subtitle 'Now: #{temperatureCelsius}°   ||   RealFeel: #{realFeelCelsius}° ' -title  ' #{condition} '}
system(msg)
