# frozen_string_literal: true

require "spec_helper"

RSpec.describe Lastfm::HttpClient do
  describe "#get" do
    it "fetches a response from the API" do
      http_client = Lastfm::HttpClient.null(
        "recenttracks" => {
          "track" => [],
          "@attr" => {"totalPages" => 1}
        }
      )

      get = http_client.get(
        Lastfm::RecentTrackList,
        user: "TEST_USER",
        page: 1,
        from: 1479316791,
        to: 1479316791
      )

      expect(get).to eq Lastfm::RecentTrackList.build(
        tracks: [],
        total_pages: 1
      )
    end
  end
end
