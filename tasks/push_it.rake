require 'spree/zapier'

namespace :zapier do
  desc 'Push batches to Zapier'
  task :push_it => :environment do

    if Spree::Zapier::Config[:connection_token] == "YOUR TOKEN" || Spree::Zapier::Config[:connection_id] == "YOUR CONNECTION ID"
      abort("[ERROR] It looks like you did not add your Zapier credentails to config/intializers/zapier.rb, please add them and try again. Exiting now")
    end
    puts "\n\n"
    puts "Starting pushing objects to Zapier"
    Spree::Zapier::Config[:push_objects].each do |object|
      objects_pushed_count = Spree::Zapier::Client.push_batches(object)
      puts "Pushed #{objects_pushed_count} #{object} to Zapier"
    end
  end
end
