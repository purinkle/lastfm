# frozen_string_literal: true
require "spec_helper"

module Lastfm
  RSpec.describe Adapter do
    describe "#total_pages" do
      it "returns the total number of pages" do
        total_pages = "0"
        data = {
          "recenttracks" => { "@attr" => { "totalPages" => total_pages } },
        }

        expect(Adapter.new(data).total_pages).to eq total_pages.to_i
      end
    end

    describe "#tracks" do
      it "is a list of adapted tracks" do
        artist_name = "TEST_ARTIST"
        track_name = "TEST_TRACK"
        data = {
          "recenttracks" => {
            "track" => [
              { "artist" => { "#text" => artist_name }, "name" => track_name },
            ],
          },
        }

        tracks = Adapter.new(data).tracks
        track = tracks.first

        expect(tracks.count).to eq 1
        expect(track.artist_name).to eq artist_name
        expect(track.name).to eq track_name
      end
    end
  end
end
