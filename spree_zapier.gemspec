# encoding: UTF-8
Gem::Specification.new do |s|
  s.authors       = ["Joe Swann"]
  s.email         = ["joe@pixelbash.co.nz"]
  s.summary       = "Webhooks and Push API implemention for Zapier"
  s.description   = s.summary
  s.version       = '3.4.0.1'
  s.homepage      = "https://github.com/Pixelbash/spree_zapier"

  s.files         = `git ls-files`.split($\)
  s.executables   = s.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.name          = "spree_zapier"
  s.require_paths = ["lib"]

  s.add_dependency 'spree_core', '>= 3.1.0', '< 4.0'
  s.add_dependency 'active_model_serializers', '0.9.0'
  s.add_dependency 'httparty'

  s.add_development_dependency 'capybara', '~> 2.1'
  s.add_development_dependency 'coffee-rails', '~> 4.0.0'
  s.add_development_dependency 'database_cleaner', '~> 1.3.0' # 1.4.0 is broken https://github.com/DatabaseCleaner/database_cleaner/issues/317
  s.add_development_dependency 'factory_girl', '~> 4.4'
  s.add_development_dependency 'ffaker'
  s.add_development_dependency 'mysql2'
  s.add_development_dependency 'pg'
  s.add_development_dependency 'rspec-rails',  '~> 2.13'
  s.add_development_dependency 'sass-rails', '~> 4.0.0'
  s.add_development_dependency 'selenium-webdriver'
  s.add_development_dependency 'simplecov'
  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'timecop'
end
