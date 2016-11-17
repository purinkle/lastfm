# frozen_string_literal: true
require "spec_helper"

module Lastfm
  RSpec.describe Entry do
    describe "#artist_name" do
      it "is the name of the initialized track's artist" do
        artist_name = "TEST_ARTIST"
        track = instance_double("Track", artist_name: artist_name)
        entry = Entry.new(play_count: 1, track: track)

        expect(entry.artist_name).to eq artist_name
      end
    end

    describe "#play_count" do
      it "is the initialized play count" do
        play_count = 1
        track = instance_double("Track")
        entry = Entry.new(play_count: play_count, track: track)

        expect(entry.play_count).to eq play_count
      end
    end

    describe "#track_name" do
      it "is the name of the initialized track's" do
        track_name = "TEST_TRACK"
        track = instance_double("Track", name: track_name)
        entry = Entry.new(play_count: 1, track: track)

        expect(entry.track_name).to eq track_name
      end
    end
  end
end
