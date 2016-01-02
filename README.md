# Get Gem Data Script

## _Or an exercise in getting cron to run Ruby scripts_

The `get_gem_data` script looks at your gem on rubgems.org and records how many downloads it has. It records this in a JSON object using the date as the key. It dumps the JSON in the same directory as the script resides in. I wrote the script intending it to be run once a day using cron, adding each day's stats to the existing JSON.

## Getting cron to execute a Ruby script with RVM

I used

```
rvm cron setup
```

This is how my crontab looks now (`crontab -e`):

```
#sm start rvm
PATH="/Users/Claire/.rvm/gems/ruby-2.2.1/bin:/Users/Claire/.rvm/gems/ruby-2.2.1@global/bin:/Users/Claire/.rvm/rubies/ruby-2.2.1/bin:/Users/Claire/.rvm/gems/ruby-2.2.1/bin:/Users/Claire/.rvm/gems/ruby-2.2.1@global/bin:/Users/Claire/.rvm/rubies/ruby-2.2.1/bin:/Users/Claire/.rvm/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
GEM_HOME='/Users/Claire/.rvm/gems/ruby-2.2.1'
GEM_PATH='/Users/Claire/.rvm/gems/ruby-2.2.1:/Users/Claire/.rvm/gems/ruby-2.2.1@global'
MY_RUBY_HOME='/Users/Claire/.rvm/rubies/ruby-2.2.1'
IRBRC='/Users/Claire/.rvm/rubies/ruby-2.2.1/.irbrc'
RUBY_VERSION='ruby-2.2.1'
#sm end rvm

01 00 * * * /Users/Claire/.rvm/wrappers/ruby-2.2.1@gemanalysis/ruby /Users/Claire/dev/gemAnalysis/get_gem_data.rb
```

There is an rvm gemset call gemanalysis which contains the Mechanize and Nokogiri gems needed to run the script.

### Improvements

* It could be classed and called from a separate Ruby script for the separate gems but meh.
* It could record the version of the gem.
