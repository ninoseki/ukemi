# frozen_string_literal: true

require "passivetotal"

module Ukemi
  module Services
    class PassiveTotal < Service
      private

      def api
        @api ||= ::PassiveTotal::API.new
      end

      def config_keys
        %w(PASSIVETOTAL_USERNAME PASSIVETOTAL_API_KEY)
      end

      def lookup_by_ip(data)
        res = api.dns.passive(data)
        results = res.dig("results") || []
        convert_to_records results
      end

      def lookup_by_domain(_data)
        []
      end

      def convert_to_records(results)
        results.map do |result|
          data = result.dig("resolve")
          first_seen = result.dig("firstSeen").to_s.split.first
          last_seen = result.dig("lastSeen").to_s.split.first
          Record.new(
            data: data,
            first_seen: first_seen,
            last_seen: last_seen,
            source: name
          )
        end
      end
    end
  end
end
