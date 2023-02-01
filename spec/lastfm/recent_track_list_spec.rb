# frozen_string_literal: true

require "spec_helper"

module Lastfm
  RSpec.describe RecentTrackList do
    describe ".build" do
      it "provides a simple way to build a recent track list" do
        recent_track_list = RecentTrackList.build(
          tracks: [
            {
              artist_name: "TEST_ARTIST",
              track_name: "TEST_TRACK"
            }
          ],
          total_pages: "1"
        )

        expect(recent_track_list).to eq RecentTrackList.new(
          "recenttracks" => {
            "track" => [
              {
                "artist" => {"#text" => "TEST_ARTIST"},
                "name" => "TEST_TRACK"
              }
            ],
            "@attr" => {"totalPages" => "1"}
          }
        )
      end
    end

    describe "#==" do
      context "when the tracks and total pages are the same" do
        it "is equal" do
          recent_track_list = build_recent_track_list
          same = build_recent_track_list

          expect(recent_track_list).to eq same
        end
      end

      context "when the track is different" do
        it "is not equal" do
          recent_track_list =
            build_recent_track_list(tracks: [build_track(track_name: "TRACK")])
          different =
            build_recent_track_list(tracks: [build_track(track_name: "OTHER")])

          expect(recent_track_list).not_to eq different
        end
      end

      context "when the total pages is different" do
        it "is not equal" do
          recent_track_list = build_recent_track_list(total_pages: 1)
          different = build_recent_track_list(total_pages: 2)

          expect(recent_track_list).not_to eq different
        end
      end
    end

    describe "#to_h" do
      it "returns a hash representation of the instance" do
        recent_track_list = RecentTrackList.build(
          tracks: [
            {
              artist_name: "TEST_ARTIST",
              track_name: "TEST_TRACK"
            }
          ],
          total_pages: "1"
        )

        to_h = recent_track_list.to_h

        expect(to_h).to eq(
          "recenttracks" => {
            "track" => [
              {
                "artist" => {"#text" => "TEST_ARTIST"},
                "name" => "TEST_TRACK"
              }
            ],
            "@attr" => {"totalPages" => "1"}
          }
        )
      end
    end

    describe "#total_pages" do
      it "returns the total number of pages" do
        total_pages = "0"
        data = {
          "recenttracks" => {"@attr" => {"totalPages" => total_pages}}
        }

        expect(RecentTrackList.new(data).total_pages).to eq total_pages.to_i
      end
    end

    describe "#tracks" do
      it "is a list of adapted tracks" do
        artist_name = "TEST_ARTIST"
        track_name = "TEST_TRACK"
        data = {
          "recenttracks" => {
            "track" => [
              {"artist" => {"#text" => artist_name}, "name" => track_name}
            ]
          }
        }

        tracks = RecentTrackList.new(data).tracks
        track = tracks.first

        expect(tracks.count).to eq 1
        expect(track.artist_name).to eq artist_name
        expect(track.name).to eq track_name
      end
    end

    def build_recent_track_list(tracks: [build_track], total_pages: 1)
      RecentTrackList.new(
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
