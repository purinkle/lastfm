# frozen_string_literal: true

module Lastfm
  class Adapter
    def self.build(tracks:, total_pages:)
      new(
        "recenttracks" => {
          "track" => tracks.map do |track|
            {
              "artist" => {"#text" => track[:artist_name]},
              "name" => track[:track_name]
            }
          end,
          "@attr" => {"totalPages" => total_pages.to_s}
        }
      )
    end

    def initialize(data)
      @data = data
    end

    def ==(other)
      tracks == other.tracks && total_pages == other.total_pages
    end

    def total_pages
      attributes.fetch("totalPages").to_i
    end

    def tracks
      track.reduce([]) do |memo, track_data|
        if track_data.fetch("@attr", {}).fetch("nowplaying", false)
          memo
        else
          memo << Track.new(track_data)
        end
      end
    end

    private

    attr_reader :data

    def attributes
      recent_tracks.fetch("@attr")
    end

    def recent_tracks
      data.fetch("recenttracks")
    end

    def track
      recent_tracks.fetch("track")
    end
  end
end
