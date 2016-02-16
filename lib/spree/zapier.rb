require 'spree/core'

module Spree
  module Zapier
  end
end

require 'spree/zapier/client'
require 'spree/zapier/engine'
require 'spree/zapier/responder'

require 'spree/zapier/handler/base'

require 'spree/zapier/handler/product_handler_base'
require 'spree/zapier/handler/add_product_handler'
require 'spree/zapier/handler/update_product_handler'

require 'spree/zapier/handler/order_handler_base'
require 'spree/zapier/handler/add_order_handler'
require 'spree/zapier/handler/update_order_handler'

require 'spree/zapier/handler/set_inventory_handler'

require 'spree/zapier/handler/set_price_handler'

require 'spree/zapier/handler/add_shipment_handler'
require 'spree/zapier/handler/update_shipment_handler'

require 'spree/zapier/handler/customer_handler_base'
require 'spree/zapier/handler/add_customer_handler'
require 'spree/zapier/handler/update_customer_handler'

require 'spree/zapier/handler/add_customer_return_handler'
