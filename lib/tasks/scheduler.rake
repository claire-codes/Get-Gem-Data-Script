desc "This task is called by the Heroku scheduler add-on"
task :say_hello => :environment do
  puts "Whoopsie doodle"
end
