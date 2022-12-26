# frozen_string_literal: true

require "spec_helper"

module Lastfm
  RSpec.describe Chart do
    describe "#get" do
      it "the recent tracks as a chart" do
        chart = []
        from = Time.now
        response_1 = instance_double("RecentTrackList", total_pages: 2)
        connection_1 = instance_double("Connection")
        response_2 = instance_double("RecentTrackList", total_pages: 2)
        connection_2 = instance_double("Connection")
        query = instance_double("Query")
        recent_tracks = instance_double("RecentTracks", to_chart: chart)
        to = Time.now
        user = "TEST_USER"
        allow(connection_1).to receive(:recent_tracks).with(from..to)
          .and_return(response_1)
        allow(Connection).to receive(:new).once.with(
          page_number: 1,
          query: query
        ).and_return(connection_1)
        allow(connection_2).to receive(:recent_tracks).with(from..to, 2)
          .and_return(response_2)
        allow(Connection).to receive(:new).once.with(
          page_number: 2,
          query: query
        ).and_return(connection_2)
        allow(Query).to receive(:new).once.with(user: user).and_return(query)
        allow(RecentTracks).to receive(:new).once.with(
          [
            response_1,
            response_2
          ]
        ).and_return(recent_tracks)

        expect(Chart.new(from: from, to: to, user: user).get).to eq chart
      end
    end
  end
end
