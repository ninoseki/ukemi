# frozen_string_literal: true

require "json"
require "thor"

module Ukemi
  class CLI < Thor
    desc "lookup [IP|DOMAIN]", "Lookup passive DNS services"
    def lookup(data)
      data = refang(data)
      result = Moderator.lookup(data)
      puts JSON.pretty_generate(result)
    end

    no_commands do
      def refang(data)
        data.gsub("[.]", ".").gsub("(.)", ".")
      end
    end
  end
end
