# frozen_string_literal: true
module Lastfm
  class Adapter
    def initialize(data)
      @data = data
    end

    def total_pages
      attributes.fetch("totalPages").to_i
    end

    def tracks
      track.map { |track_data| Track.new(track_data) }
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
