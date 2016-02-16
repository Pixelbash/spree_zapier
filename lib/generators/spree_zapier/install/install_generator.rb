module SpreeZapier
  module Generators
    class InstallGenerator < Rails::Generators::Base

      source_root File.expand_path("../templates", __FILE__)

      def add_initializer
        copy_file "zapier.rb", "config/initializers/zapier.rb"
        append_file "config/application.rb", %Q{
# Load Zapier webhook handlers
Dir.glob(File.join(File.dirname(__FILE__), "../lib/**/*_handler.rb")) do |c|
  Rails.configuration.cache_classes ? require(c) : load(c)
end
        }
      end

    end
  end
end
