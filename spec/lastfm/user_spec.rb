# frozen_string_literal: true

require "spec_helper"

module Lastfm
  RSpec.describe User do
    describe "#recent_tracks" do
      it "fetches a list of all recently played tracks that match the query" do
        http_client = HttpClient.null(
          {
            user: "TEST_USER",
            page: 2,
            from: 1479316791,
            to: 1479316791
          } => {
            "recenttracks" => {
              "track" => [
                {
                  "artist" => {"#text" => "TEST_ARTIST_1"},
                  "name" => "TEST_TRACK_1"
                }
              ],
              "@attr" => {"totalPages" => 2}
            }
          }
        )
        user = User.new("TEST_USER", http_client)

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
            {period: (from..to)} => {
              "recenttracks" => {
                "track" => [
                  {
                    "artist" => {"#text" => "TEST_ARTIST"},
                    "name" => "TEST_TRACK"
                  }
                ],
                "@attr" => {"totalPages" => 1}
              }
            }
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
