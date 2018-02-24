# frozen_string_literal: true
require "spec_helper"

module Lastfm
  RSpec.describe Tracks do
    describe "#to_chart" do
      it "is all tracks sorted by play count" do
        artist_name1 = "TEST_ARTIST_1"
        artist_name2 = "TEST_ARTIST_2"
        track_name1 = "TEST_TRACK_1"
        track_name2 = "TEST_TRACK_2"
        track1 = Track.new(
          "artist" => { "#text" => artist_name1 },
          "name" => track_name1,
        )
        track2 = Track.new(
          "artist" => { "#text" => artist_name2 },
          "name" => track_name2,
        )
        tracks = [track2, track1, track1]

        entries = Tracks.new(tracks).to_chart

        expect(entries.count).to eq 2
        [
          [artist_name1, 2, track_name1],
          [artist_name2, 1, track_name2],
        ].each_with_index do |(artist_name, play_count, track_name), index|
          expect(entries[index].artist_name).to eq artist_name
          expect(entries[index].play_count).to eq play_count
          expect(entries[index].track_name).to eq track_name
        end
      end
    end
  end
end
