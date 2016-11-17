# frozen_string_literal: true
require "spec_helper"

module Lastfm
  RSpec.describe Connection do
    describe "#get" do
      it "is the response body" do
        VCR.use_cassette("recent_tracks/none") do
          adapted_response = instance_double("Adapter")
          adapter = class_double("Adapter")
          from = Time.at(1_479_316_791).to_i
          to = Time.at(1_479_316_791).to_i
          user = "TEST_USER"
          body = {
            "recenttracks" => {
              "@attr" => {
                "page" => "1",
                "perPage" => "1",
                "total" => "0",
                "totalPages" => "0",
                "user" => user,
              },
              "track" => [],
            },
          }
          query = instance_double("Query", from: from, to: to, user: user)
          allow(adapter).to receive(:new).once.with(body).
            and_return(adapted_response)
          connection = Connection.new(adapter: adapter, query: query)

          expect(connection.get).to eq adapted_response
        end
      end
    end
  end
end
