# frozen_string_literal: true
module Lastfm
  class Track
    def self.build(artist_name:, track_name:)
      new(
        "artist" => {"#text" => artist_name},
        "name" => track_name
      )
    end

    def initialize(data)
      @data = data
    end

    def artist_name
      artist.name
    end

    def date
      data.fetch("date").fetch("uts")
    end

    def eql?(other)
      self == other
    end

    def hash
      [artist_name, name].hash
    end

    def name
      data.fetch("name")
    end

    def ==(other)
      other.artist_name == artist_name && other.name == name
    end

    private

    attr_reader :data

    def artist
      Artist.new(artist_data)
    end

    def artist_data
      data.fetch("artist")
    end
  end
end
