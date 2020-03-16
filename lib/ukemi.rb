# frozen_string_literal: true

require "mem"

module Ukemi
  class << self
    include Mem

    def services
      []
    end
    memoize :services
  end
end

require "ukemi/version"

require "ukemi/error"

require "ukemi/record"

require "ukemi/services/service"

require "ukemi/services/circl"
require "ukemi/services/passivetotal"
require "ukemi/services/securitytrails"
require "ukemi/services/virustotal"

require "ukemi/moderator"

require "ukemi/configuration"

require "ukemi/cli"
