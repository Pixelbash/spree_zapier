require 'json'
require 'openssl'
require 'httparty'
require 'active_model/array_serializer'

module Spree
  module Zapier
    class Client

      def self.push_batches(object, ts_offset = 5)
        object_count = 0

        last_push_time = Spree::Zapier::Config[:last_pushed_timestamps][object] || Time.at(0)
        this_push_time = Time.now

        payload_builder = Spree::Zapier::Config[:payload_builder][object]

        model_name = payload_builder[:model].present? ? payload_builder[:model] : object

        scope = model_name.constantize

        if filter = payload_builder[:filter]
          scope = scope.send(filter.to_sym)
        end

        # go 'ts_offset' seconds back in time to catch missing objects
        last_push_time = last_push_time - ts_offset.seconds

        scope.where(updated_at: last_push_time...this_push_time).find_in_batches(batch_size: Spree::Zapier::Config[:batch_size]) do |batch|
          object_count += batch.size
          payload = ActiveModel::ArraySerializer.new(
            batch,
            each_serializer: payload_builder[:serializer].constantize,
            root: payload_builder[:root]
          ).to_json

          push(payload) unless object_count == 0
        end

        update_last_pushed(object, this_push_time) unless object_count == 0
        object_count
      end

      def self.push_one(object, find = false, ts_offset = 5)
        object_count = 0

        last_push_time = Spree::Zapier::Config[:last_pushed_timestamps][object] || Time.at(0)
        this_push_time = Time.now

        payload_builder = Spree::Zapier::Config[:payload_builder][object]

        model_name = payload_builder[:model].present? ? payload_builder[:model] : object

        scope = model_name.constantize

        if filter = payload_builder[:filter]
          scope = scope.send(filter.to_sym)
        end

        # go 'ts_offset' seconds back in time to catch missing objects
        last_push_time = last_push_time - ts_offset.seconds

        # Get batch as first result
        batch = scope.where(updated_at: last_push_time...this_push_time).find_in_batches(batch_size: Spree::Zapier::Config[:batch_size]).first

        object_count += batch.size
        payload = ActiveModel::ArraySerializer.new(
          batch,
          each_serializer: payload_builder[:serializer].constantize,
          root: payload_builder[:root]
        ).to_json

        push(payload) unless object_count == 0

        # update_last_pushed(object, this_push_time) unless object_count == 0
        object_count
      end

      def self.push(json_payload)
        res = HTTParty.post(
          Spree::Zapier::Config[:push_url],
          {
            body: json_payload,
            basic_auth: Spree::Zapier::Config[:auth],
            headers: {
             'Content-Type'  => 'application/json',
             'Authorization' => 'api_key==N3qi}u-9)S4rq1mNz18MMi/uNV}9D', #Not required for orchestrate
             'X-Timestamp'   => Time.now.utc.to_i.to_s
            }
          }
        )

        validate(res)
      end

      private
      def self.update_last_pushed(object, new_last_pushed)
        last_pushed_ts = Spree::Zapier::Config[:last_pushed_timestamps]
        last_pushed_ts[object] = new_last_pushed
        Spree::Zapier::Config[:last_pushed_timestamps] = last_pushed_ts
      end

      def self.validate(res)
        raise PushApiError, "Push not successful. Zapier returned response code #{res.code} and message: #{res.body}" if res.code != 200
      end
    end
  end
end

class PushApiError < StandardError; end
