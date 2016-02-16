require 'active_model/serializer'

module Spree
  module Zapier
    class ReimbursementSerializer < ActiveModel::Serializer
      attributes :id, :order_id, :total, :paid_amount, :reimbursement_status, :refunds
      has_many :return_items, serializer: Spree::Zapier::ReturnItemSerializer
      has_many :refunds, serializer: Spree::Zapier::RefundSerializer

      def id
        object.number
      end

      def order_id
        object.order.try(:number)
      end
    end
  end
end
