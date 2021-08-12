# frozen_string_literal: true

require "date"
require "virustotal"

module Ukemi
  module Services
    class VirusTotal < Service
      private

      def config_keys
        %w[VIRUSTOTAL_API_KEY]
      end

      def api
        @api ||= ::VirusTotal::API.new
      end

      def lookup_by_ip(data)
        res = api.ip_address.resolutions(data)
        attributes = extract_attributes(res)
        convert_to_records attributes, "host_name"
      end

      def lookup_by_domain(data)
        res = api.domain.resolutions(data)
        attributes = extract_attributes(res)
        convert_to_records attributes, "ip_address"
      end

      def extract_attributes(response)
        data = response["data"] || []
        data.map do |item|
          item["attributes"] || []
        end
      end

      def convert_to_records(attributes, key = nil)
        memo = Hash.new { |h, k| h[k] = [] }

        attributes.each do |attribute|
          data = attribute[key]
          date = Time.at(attribute["date"]).to_date.to_s
          memo[data] << date
        end

        memo.keys.map do |data|
          Record.new(
            data: data,
            first_seen: memo[data].min,
            last_seen: memo[data].max,
            source: name
          )
        end
      end
    end
  end
end
