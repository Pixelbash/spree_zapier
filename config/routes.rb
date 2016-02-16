Spree::Core::Engine.add_routes do
  namespace :zapier do
    post '*path', to: 'webhook#consume', as: 'webhook'
  end
end
