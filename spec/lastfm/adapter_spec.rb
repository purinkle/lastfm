# frozen_string_literal: true
require "spec_helper"

module Lastfm
  RSpec.describe Adapter do
    describe "#==" do
      context "when the tracks and total pages are the same" do
        it "is equal" do
          adapter = build_adapter
          same = build_adapter

          expect(adapter).to eq same
        end
      end

      context "when the track is different" do
        it "is not equal" do
          adapter = build_adapter(tracks: [build_track(track_name: "TRACK")])
          different = build_adapter(tracks: [build_track(track_name: "OTHER")])

          expect(adapter).not_to eq different
        end
      end

      context "when the total pages is different" do
        it "is not equal" do
          adapter = build_adapter(total_pages: 1)
          different = build_adapter(total_pages: 2)

          expect(adapter).not_to eq different
        end
      end
    end

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

    def build_adapter(tracks: [build_track], total_pages: 1)
      Adapter.new(
        "recenttracks" => {
          "track" => tracks,
          "@attr" => {"totalPages" => total_pages.to_s}
        }
      )
    end

    def build_track(artist_name: "TEST_ARTIST", track_name: "TEST_TRACK")
      {
        "artist" => {"#text" => artist_name},
        "name" => track_name
      }
    end
  end
end
