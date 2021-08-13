# frozen_string_literal: true

require "json"
require "thor"

module Ukemi
  class CLI < Thor
    desc "lookup [IP|DOMAIN]", "Lookup passive DNS services"
    method_option :order_by, type: :string, desc: "Ordering of the passve DNS resolutions (last_seen or first_seen)", default: "-last_seen"
    def lookup(data)
      data = refang(data)
      set_ordering options["order_by"]

      result = Moderator.lookup(data)
      puts JSON.pretty_generate(result)
    end

    default_command :lookup

    no_commands do
      def refang(data)
        data.gsub("[.]", ".").gsub("(.)", ".")
      end

      def set_ordering(order_by)
        parts = order_by.split("-")
        ordering_key = parts.last
        sort_order = parts.length == 2 ? "DESC" : "ASC"

        Ukemi.configure do |config|
          config.ordering_key = ordering_key
          config.sort_order = sort_order
        end
      end
    end
  end
end
