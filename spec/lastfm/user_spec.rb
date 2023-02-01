# frozen_string_literal: true

require "spec_helper"

module Lastfm
  RSpec.describe User do
    describe "#recent_tracks" do
      it "fetches a list of all recently played tracks that match the query" do
        VCR.use_cassette("recent_tracks/page_2") do
          user = User.new("TEST_USER")

          from = Time.new(2016, 11, 16, 17, 19, 51)
          to = Time.new(2016, 11, 16, 17, 19, 51)
          recent_tracks = user.recent_tracks(from..to, 2)

          expect(recent_tracks).to eq RecentTrackList.build(
            tracks: [
              {
                artist_name: "TEST_ARTIST_1",
                track_name: "TEST_TRACK_1"
              }
            ],
            total_pages: 2
          )
        end
      end

      context "when we omit a page number" do
        it "defaults to the first page" do
          VCR.use_cassette("recent_tracks/one") do
            user = User.new("TEST_USER")

            from = Time.new(2016, 11, 16, 17, 19, 51)
            to = Time.new(2016, 11, 16, 17, 19, 51)
            recent_tracks = user.recent_tracks(from..to)

            expect(recent_tracks).to eq RecentTrackList.build(
              tracks: [
                {
                  artist_name: "TEST_ARTIST",
                  track_name: "TEST_TRACK"
                }
              ],
              total_pages: 1
            )
          end
        end
      end

      context "when nulled without a configuration" do
        it "returns the default recent track list" do
          user = User.null("TEST_USER")

          from = Time.new(2016, 11, 16, 17, 19, 51)
          to = Time.new(2016, 11, 16, 17, 19, 51)
          recent_tracks = user.recent_tracks(from..to)

          expect(recent_tracks).to eq RecentTrackList.build(
            tracks: [],
            total_pages: 1
          )
        end
      end

      context "when nulled with a configuration" do
        it "returns the correct response" do
          from = Time.new(2016, 11, 16, 17, 19, 51)
          to = Time.new(2016, 11, 16, 17, 19, 51)
          recent_track_lists = {
            {period: (from..to)} => RecentTrackList.build(
              tracks: [
                {
                  artist_name: "TEST_ARTIST",
                  track_name: "TEST_TRACK"
                }
              ],
              total_pages: 1
            )
          }
          user = User.null("TEST_USER", recent_track_lists)

          recent_tracks = user.recent_tracks(from..to)

          expect(recent_tracks).to eq RecentTrackList.build(
            tracks: [
              {
                artist_name: "TEST_ARTIST",
                track_name: "TEST_TRACK"
              }
            ],
            total_pages: 1
          )
        end
      end
    end
  end
end
