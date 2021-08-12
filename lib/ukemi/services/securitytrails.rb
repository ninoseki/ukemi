# frozen_string_literal: true

require "date"
require "securitytrails"

module Ukemi
  module Services
    class SecurityTrails < Service
      private

      def config_keys
        %w[SECURITYTRAILS_API_KEY]
      end

      def api
        @api ||= ::SecurityTrails::API.new
      end

      def lookup_by_ip(data)
        result = api.domains.search(filter: { ipv4: data })
        records = result["records"] || []
        hostnames = records.map { |record| record["hostname"] }
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
        records = result["records"] || []

        memo = Hash.new { |h, k| h[k] = [] }
        records.each do |record|
          values = record["values"] || []
          values.each do |value|
            ip = value["ip"]
            memo[ip] << record["first_seen"]
            memo[ip] << record["last_seen"]
          end
        end

        memo.keys.map do |ip|
          Record.new(
            data: ip,
            first_seen: memo[ip].min,
            last_seen: memo[ip].max,
            source: name
          )
        end
      end
    end
  end
end
