require 'spree/zapier'

namespace :zapier do
  desc 'Push batches to Zapier'
  task :push => :environment do
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

  desc 'Set push date to date/time (default is now). Usage: zapier:last_pushed date=16/12/2016'
  task :last_pushed, : => :environment do |t, args|
    # Get time, from args if necessary
    time = Time.now
    if ENV['date'].present?
      time = Time.strptime(ENV['date'].to_s, "%d/%m/%Y")
    end

    # Set time
    Spree::Zapier::Config[:push_objects].each do |object|
      last_pushed_ts = Spree::Zapier::Config[:last_pushed_timestamps]
      last_pushed_ts[object] = time
      Spree::Zapier::Config[:last_pushed_timestamps] = last_pushed_ts
      puts "Reset last pushed timestamp for #{object}"
    end
  end

  desc 'How many objects are there to push'
  task :count_unpushed => :environment do
    Spree::Zapier::Config[:push_objects].each do |object|
      last_push_time = Spree::Zapier::Config[:last_pushed_timestamps][object] || Time.at(0)
      this_push_time = Time.now

      scope = object.constantize
      count = scope.where(updated_at: last_push_time...this_push_time).count

      puts "There are #{count} unpushed objects for #{object}"
    end
  end
end
