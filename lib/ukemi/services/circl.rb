# frozen_string_literal: true

require "passive_circl"

module Ukemi
  module Services
    class CIRCL < Service
      private

      def config_keys
        %w(CIRCL_PASSIVE_USERNAME CIRCL_PASSIVE_PASSWORD)
      end

      def api
        @api ||= PassiveCIRCL::API.new
      end

      def lookup_by_domain(data)
        passive_dns_lookup(data, "rdata")
      end

      def lookup_by_ip(data)
        passive_dns_lookup(data, "rrname")
      end

      def passive_dns_lookup(data, key = nil)
        results = api.dns.query(data)
        results = results.select do |result|
          result.dig("rrtype") == "A"
        end

        results.map do |result|
          Record.new(
            data: result.dig(key),
            first_seen: Time.at(result.dig("time_first")).to_date.to_s,
            last_seen: Time.at(result.dig("time_last")).to_date.to_s,
            source: name
          )
        end
      end
    end
  end
end
