# frozen_string_literal: true

module Lastfm
  class Artist
    def initialize(data)
      @data = data
    end

    def name
      data.fetch("#text")
    end

    private

    attr_reader :data
  end
end
