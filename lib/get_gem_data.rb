#!/usr/bin/env ruby

require 'mechanize'
require 'nokogiri'
require 'json'
require 'gems'
require 'mongoid'
require_relative './Stat'

Mongoid.load!('mongoid.yml', :development)

def scrape_stat(gem_name)
  page = Mechanize.new.get("https://rubygems.org/gems/#{gem_name}")
  gem_stats = page.search('.gem__downloads')
  gem_stats[0].text
end

def api_stat(gem_name)
  Gems.info(gem_name)['downloads'].to_s
end

def record_downloads_for(gem_name)
  filepath = File.join(File.expand_path('..', File.dirname(__FILE__)), "#{gem_name}-data.json")
  hash = {}

  if File.exist?(filepath)
    puts "Writing to #{filepath}"
    prev_data = File.read(filepath)
    hash = JSON.parse(prev_data)
  end

  todays_stat = api_stat(gem_name)
  todays_date = Time.now.strftime('%d-%m-%y')
  hash[todays_date] = todays_stat

  File.open(filepath, 'w') do |file|
    file.puts JSON.pretty_generate(hash)
    puts "Written #{todays_stat}"
  end
end
