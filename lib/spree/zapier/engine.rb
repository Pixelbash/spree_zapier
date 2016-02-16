module Spree
  module Zapier
    class Engine < Rails::Engine
      isolate_namespace Spree
      engine_name 'spree_zapier'

      rake_tasks do
        load File.join(root, "tasks","push.rake")
      end

      initializer "spree.zapier.environment", :before => :load_config_initializers do |app|
        Spree::Zapier::Config = Spree::ZapierConfiguration.new
      end

      def self.activate
        Dir.glob(File.join(File.dirname(__FILE__), "../../../app/**/*_decorator*.rb")) do |c|
          Rails.configuration.cache_classes ? require(c) : load(c)
        end
      end
      config.to_prepare &method(:activate).to_proc

      def self.root
        @root ||= Pathname.new(File.expand_path('../../../../', __FILE__))
      end
    end
  end
end
