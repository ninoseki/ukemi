# frozen_string_literal: true

module Ukemi
  class Configuration
    attr_accessor :ordering_key, :sort_order

    def initialize
      @ordering_key = "last_seen"
      @sort_order = "DESC"
    end
  end

  class << self
    def configuration
      @configuration ||= Configuration.new
    end

    attr_writer :configuration

    def configure
      yield configuration
    end
  end
end
