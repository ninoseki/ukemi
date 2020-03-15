# frozen_string_literal: true

require "parallel"
require "time"

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

      memo = Hash.new { |h, k| h[k] = [] }
      records.each do |record|
        memo[record.data] << {
          firtst_seen: record.first_seen,
          last_seen: record.last_seen,
          source: record.source,
        }
      end

      memo.sort_by do |_key, array|
        last_seens = array.map do |record|
          parse_to_unixtime record.dig(:last_seen)
        end
        -last_seens.max
      end.to_h
    end

    def parse_to_unixtime(date)
      return -1 unless date

      Time.parse(date).to_i
    end

    class << self
      def lookup(data)
        new.lookup data
      end
    end
  end
end
