# frozen_string_literal: true

module Lastfm
  class RecentTracks
    def initialize(pages)
      @pages = pages
    end

    def to_chart
      tracks.to_chart
    end

    private

    attr_reader :pages

    def tracks
      Tracks.new(pages.flat_map(&:tracks))
    end

    def tracks_data
      pages.flat_map { |page| page.fetch("recenttracks").fetch("track") }
    end
  end
end
