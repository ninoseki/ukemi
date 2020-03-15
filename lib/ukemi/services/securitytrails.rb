# frozen_string_literal: true

require "date"
require "securitytrails"

module Ukemi
  module Services
    class SecurityTrails < Service
      private

      def config_keys
        %w(SECURITYTRAILS_API_KEY)
      end

      def api
        @api ||= ::SecurityTrails::API.new
      end

      def lookup_by_ip(data)
        result = api.domains.search( filter: { ipv4: data })
        records = result.dig("records") || []
        hostnames = records.map { |record| record.dig("hostname") }
        hostnames.map do |hostname|
          Record.new(
            data: hostname,
            first_seen: nil,
            last_seen: nil,
            source: name
          )
        end
      end

      def lookup_by_domain(data)
        result = api.history.get_all_dns_history(data, type: "a")
        records = result.dig("records") || []
        records.map do |record|
          values = record.dig("values") || []
          values.map do |value|
            Record.new(
              data: value.dig("ip"),
              first_seen: record.dig("first_seen"),
              last_seen: record.dig("last_seen"),
              source: name
            )
          end
        end.flatten
      end

      def extract_attributes(response)
        data = response.dig("data") || []
        data.map do |item|
          item.dig("attributes") || []
        end
      end
    end
  end
end
