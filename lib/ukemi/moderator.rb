# frozen_string_literal: true

require "parallel"
require "time"
require "date"

module Ukemi
  class Moderator
    def lookup(data)
      records = Parallel.map(Ukemi.services) do |klass|
        service = klass.new
        next unless service.configurated?

        begin
          service.lookup data
        rescue ::PassiveTotal::Error, ::VirusTotal::Error, ::SecurityTrails::Error, PassiveCIRCL::Error
          nil
        end
      end.flatten.compact

      format records
    end

    def format(records)
      memo = Hash.new { |h, k| h[k] = [] }

      records.each do |record|
        memo[record.data] << {
          first_seen: record.first_seen,
          last_seen: record.last_seen,
          source: record.source,
        }
      end
      # Merge first seen last seen and make the sources a list.
      formatted = memo.map do |key, sources|
        first_seens = sources.map { |record| convert_to_unixtime record.dig(:first_seen) }.compact
        last_seens = sources.map { |record| convert_to_unixtime record.dig(:last_seen) }.compact
        [
          key,
          {
            first_seen: convert_to_date(first_seens.min),
            last_seen: convert_to_date(last_seens.max),
            sources: sources
          }
        ]
      end.to_h

      # Sorting
      ordering_key = Ukemi.configuration.ordering_key.to_sym
      sort_order = Ukemi.configuration.sort_order
      formatted.sort_by do |_key, hash|
        value = hash.dig(ordering_key)
        if sort_order == "DESC"
          value ? -convert_to_unixtime(value) : -1
        else
          value ? convert_to_unixtime(value) : Float::MAX.to_i
        end
      end.to_h
    end

    def convert_to_unixtime(date)
      return nil unless date

      Time.parse(date).to_i
    end

    def convert_to_date(time)
      return nil unless time

      Time.at(time).to_date.to_s
    end

    class << self
      def lookup(data)
        new.lookup data
      end
    end
  end
end
