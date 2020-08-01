# frozen_string_literal: true

require "date"
require "otx_ruby"

module Ukemi
  module Services
    class OTX < Service
      private

      def config_keys
        %w(OTX_API_KEY)
      end

      def api_key
        @api_key ||= ENV["OTX_API_KEY"]
      end

      def domain_client
        @domain_client ||= ::OTX::Domain.new(api_key)
      end

      def ip_client
        @ip_client ||= ::OTX::IP.new(api_key)
      end

      def lookup_by_ip(data)
        records = ip_client.get_passive_dns(data)
        memo = Hash.new { |h, k| h[k] = [] }
        records.each do |record|
          next if record.record_type != "A"

          domain = record.hostname
          memo[domain] <<  Date.parse(record.last).to_s
          memo[domain] <<  Date.parse(record.first).to_s
        end

        memo.keys.map do |domain|
          Record.new(
            data: domain,
            first_seen: memo[domain].min,
            last_seen: memo[domain].max,
            source: name
          )
        end
      end

      def lookup_by_domain(data)
        records = domain_client.get_passive_dns(data)

        memo = Hash.new { |h, k| h[k] = [] }
        records.each do |record|
          next if record.record_type != "A"
          next if record.hostname != data

          ip = record.address
          memo[ip] <<  Date.parse(record.last).to_s
          memo[ip] <<  Date.parse(record.first).to_s
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
