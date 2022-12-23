# frozen_string_literal: true

module Lastfm
  class Tracks
    def initialize(tracks)
      @tracks = tracks
    end

    def to_chart
      entries.sort_by(&:play_count).reverse
    end

    private

    attr_reader :tracks

    def entries
      play_counts.map do |track, play_count|
        Entry.new(play_count: play_count, track: track)
      end
    end

    def unique_tracks
      tracks.uniq { |track| [track.artist_name, track.name, track.date] }
    end

    def play_counts
      unique_tracks.each_with_object(Hash.new(0)) do |track, play_counts|
        play_counts[track] += 1
      end
    end
  end
end
