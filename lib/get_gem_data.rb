#!/usr/bin/env ruby

require 'mechanize'
require 'nokogiri'
require 'json'
require 'gems'

def scrape_stat(gem_name)
  page = Mechanize.new.get("https://rubygems.org/gems/#{gem_name}")
  gem_stats = page.search('.gem__downloads')
  gem_stats[0].text
end

def api_stat(gem_name)
  Gems.info(gem_name)["downloads"].to_s
end

def record_downloads_for(gem_name)
  total_stat = api_stat(gem_name)
  todays_date = Time.now.strftime("%d-%m-%y")

  filename = "#{gem_name}-data.json"
  filepath = File.join(File.dirname(File.expand_path(__FILE__)), filename)

  if File.exist?(filepath)
    prev_data = File.read(filepath)
    hash = JSON.parse(prev_data)
  else
    hash = {}
  end

  hash[todays_date] = total_stat
  File.open(filepath, 'w') do |file|
    file.puts JSON.pretty_generate(hash)
  end
end

record_downloads_for('emoji-commit')
record_downloads_for('cheerup')
