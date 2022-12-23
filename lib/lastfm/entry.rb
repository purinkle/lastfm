# frozen_string_literal: true

module Lastfm
  class Entry
    attr_reader :play_count

    def initialize(play_count:, track:)
      @play_count = play_count
      @track = track
    end

    def artist_name
      track.artist_name
    end

    def track_name
      track.name
    end

    private

    attr_reader :track
  end
end
