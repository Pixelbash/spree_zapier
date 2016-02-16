require 'active_model/serializer'

module Spree
  module Zapier
    class RefundSerializer < ActiveModel::Serializer
      attributes :reason, :amount, :description
      has_one :payment, serializer: Spree::Zapier::PaymentSerializer

      def reason
        object.reason.try(:name)
      end
    end
  end
end
