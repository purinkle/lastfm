# frozen_string_literal: true
require "spec_helper"

module Lastfm
  RSpec.describe Connection do
    describe "#get" do
      it "fetches a list of all recently played tracks that match the query" do
        VCR.use_cassette("recent_tracks/one") do
          connection = Connection.new(
            adapter: Adapter,
            query: Query.new(
              user: "TEST_USER",
              from: Time.new(2016, 11, 16, 17, 19, 51).to_i,
              to: Time.new(2016, 11, 16, 17, 19, 51).to_i
            )
          )

          recent_tracks = connection.get

          expect(recent_tracks).to have_attributes(
            tracks: [
              Track.new(
                "artist" => {"#text" => "TEST_ARTIST"},
                "name" => "TEST_TRACK"
              )
            ],
            total_pages: 1
          )
        end
      end
    end
  end
end
