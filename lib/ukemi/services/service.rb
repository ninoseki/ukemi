# frozen_string_literal: true

require "addressable/uri"
require "ipaddr"
require "public_suffix"

module Ukemi
  module Services
    class Service
      def name
        @name ||= self.class.to_s.split("::").last
      end

      def lookup(data)
        @data = data

        case type
        when "ip"
          lookup_by_ip data
        when "domain"
          lookup_by_domain data
        else
          raise ArgumentError, "#{data} is not a valid input."
        end
      end

      def configurated?
        config_keys.all? do |key|
          ENV.key? key
        end
      end

      class << self
        def inherited(child)
          Ukemi.services << child
        end
      end

      private

      def config_keys
        raise NotImplementedError, "You must implement #{self.class}##{__method__}"
      end

      def lookup_by_ip
        raise NotImplementedError, "You must implement #{self.class}##{__method__}"
      end

      def lookup_by_domain
        raise NotImplementedError, "You must implement #{self.class}##{__method__}"
      end

      def ip?
        IPAddr.new @data
        true
      rescue IPAddr::InvalidAddressError => _e
        false
      end

      def domain?
        uri = Addressable::URI.parse("http://#{@data}")
        uri.host == @data && PublicSuffix.valid?(uri.host)
      rescue Addressable::URI::InvalidURIError => _e
        false
      end

      def type
        return "ip" if ip?
        return "domain" if domain?
      end
    end
  end
end
