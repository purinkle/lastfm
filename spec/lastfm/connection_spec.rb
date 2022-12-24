# frozen_string_literal: true

require "spec_helper"

module Lastfm
  RSpec.describe Connection do
    describe "#recent_tracks" do
      it "fetches a list of all recently played tracks that match the query" do
        VCR.use_cassette("recent_tracks/one") do
          connection = Connection.new(
            query: Query.new(
              user: "TEST_USER",
              from: Time.new(2016, 11, 16, 17, 19, 51).to_i,
              to: Time.new(2016, 11, 16, 17, 19, 51).to_i
            )
          )

          from = Time.new(2016, 11, 16, 17, 19, 51)
          to = Time.new(2016, 11, 16, 17, 19, 51)
          recent_tracks = connection.recent_tracks(from..to)

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
