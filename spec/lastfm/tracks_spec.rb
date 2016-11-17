# frozen_string_literal: true
require "spec_helper"

module Lastfm
  RSpec.describe Tracks do
    describe "#to_chart" do
      it "is all tracks sorted by play count" do
        artist_name_1 = "TEST_ARTIST_1"
        artist_name_2 = "TEST_ARTIST_2"
        track_name_1 = "TEST_TRACK_1"
        track_name_2 = "TEST_TRACK_2"
        track_1 = Track.new(
          "artist" => { "#text" => artist_name_1 },
          "name" => track_name_1,
        )
        track_2 = Track.new(
          "artist" => { "#text" => artist_name_2 },
          "name" => track_name_2,
        )
        tracks = [track_2, track_1, track_1]

        entries = Tracks.new(tracks).to_chart

        expect(entries.count).to eq 2
        [
          [artist_name_1, 2, track_name_1],
          [artist_name_2, 1, track_name_2],
        ].each_with_index do |(artist_name, play_count, track_name), index|
          expect(entries[index].artist_name).to eq artist_name
          expect(entries[index].play_count).to eq play_count
          expect(entries[index].track_name).to eq track_name
        end
      end
    end
  end
end
