Spree::Zapier::Config.configure do |config|

  config.connection_token = "YOUR TOKEN"
  config.connection_id = "YOUR CONNECTION ID"

  # config.push_objects = ["Spree::Order", "Spree::Product"]
  # config.payload_builder = {
  #   # By default we filter orders to only push if they are completed.  You can remove the filter to send incomplete orders as well.
  #   "Spree::Order" => { serializer: "Spree::Zapier::OrderSerializer", root: "orders", filter: "complete" },
  #   "Spree::Product" => { serializer: "Spree::Zapier::ProductSerializer", root: "products" },
  #   "Spree::StockItem" => { serializer: "Spree::Zapier::StockItemSerializer", root: "inventories" }
  # }
  #config.push_url = "https://push.zapier.co"

end
