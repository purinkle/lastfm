# frozen_string_literal: true

require "spec_helper"

module Lastfm
  RSpec.describe Connection do
    describe "#get" do
      it "fetches a list of all recently played tracks that match the query" do
        VCR.use_cassette("recent_tracks/one") do
          connection = Connection.new(
            query: Query.new(
              user: "TEST_USER",
              from: Time.new(2016, 11, 16, 17, 19, 51).to_i,
              to: Time.new(2016, 11, 16, 17, 19, 51).to_i
            )
          )

          recent_tracks = connection.get

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
