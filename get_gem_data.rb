#!/usr/bin/env ruby

require 'mechanize'
require 'nokogiri'
require 'json'

def record_downloads_for(gem_name)
  page = Mechanize.new.get("https://rubygems.org/gems/#{gem_name}")
  gem_stats = page.search('.gem__downloads')
  total_stat = gem_stats[0].text
  puts "Today's total: #{total_stat}"
  todays_date = Time.now.strftime("%d-%m-%y")

  filename = "#{gem_name}-data.json"
  if File.exist?(filename)
    prev_data = File.read(filename)
    hash = JSON.parse(prev_data)
  else
    hash = {}
  end

  hash[todays_date] = total_stat
  File.open(filename, 'w') do |file|
    file.puts JSON.pretty_generate(hash)
  end
end

record_downloads_for('emoji-commit')
record_downloads_for('cheerup')
