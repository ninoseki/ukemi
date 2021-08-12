# frozen_string_literal: true

require "date"
require "dnsdb"

module Ukemi
  module Services
    class DNSDB < Service
      private

      def config_keys
        %w[DNSDB_API_KEY]
      end

      def api
        @api ||= ::DNSDB::API.new
      end

      def lookup_by_ip(data)
        results = api.lookup.rdata(type: "ip", value: data, rrtype: "A")
        results.map do |result|
          rrname = result["rrname"]
          # Remove the last dot (e.g. "example.com.")
          data = rrname[0..-2]
          Record.new(
            data: data,
            first_seen: Time.at(result["time_first"]).to_date.to_s,
            last_seen: Time.at(result["time_last"]).to_date.to_s,
            source: name
          )
        end
      end

      def lookup_by_domain(data)
        results = api.lookup.rrset(owner_name: data, rrtype: "A")
        results.map do |result|
          first_seen = Time.at(result["time_first"]).to_date.to_s
          last_seen = Time.at(result["time_last"]).to_date.to_s

          values = result["rdata"] || []
          values.map do |value|
            Record.new(
              data: value,
              first_seen: first_seen,
              last_seen: last_seen,
              source: name
            )
          end
        end.flatten
      end
    end
  end
end
