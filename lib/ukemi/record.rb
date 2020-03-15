# frozen_string_literal: true

module Ukemi
  class Record
    attr_reader :data
    attr_reader :first_seen
    attr_reader :last_seen
    attr_reader :source

    def initialize(data:, first_seen: nil, last_seen: nil, source: nil)
      @data = data
      @first_seen = first_seen
      @last_seen = last_seen
      @source = source
    end

    def to_h
      {
        data: data,
        first_seen: first_seen,
        last_seen: last_seen,
        source: source
      }
    end
  end
end
