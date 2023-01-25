# frozen_string_literal: true

require "spec_helper"

module Lastfm
  RSpec.describe HttpClient do
    describe "#get" do
      it "returns the given entity" do
        VCR.use_cassette("recent_tracks/page_2") do
          http_client = Lastfm::HttpClient.new
          stub_const("ExampleEntity", example_entity)

          response = http_client.get(
            ExampleEntity,
            user: "TEST_USER",
            page: 2,
            from: 1479316791,
            to: 1479316791
          )

          expect(response).to eq ExampleEntity.new(
            "recenttracks" => {
              "@attr" => {
                "page" => "2",
                "perPage" => "2",
                "total" => "3",
                "totalPages" => "2",
                "user" => "TEST_USER"
              },
              "track" => [
                {
                  "artist" => {"#text" => "TEST_ARTIST_1"},
                  "date" => {"uts" => "1_479_316_792"},
                  "name" => "TEST_TRACK_1"
                }
              ]
            }
          )
        end
      end
    end

    def example_entity
      Class.new do
        attr_reader :response_body

        def initialize(response_body)
          @response_body = response_body
        end

        def ==(other)
          response_body == other.response_body
        end
      end
    end
  end
end
