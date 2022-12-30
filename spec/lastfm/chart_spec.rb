# frozen_string_literal: true

require "spec_helper"

module Lastfm
  RSpec.describe Chart do
    describe "#get" do
      it "the recent tracks as a chart" do
        chart = []
        from = Time.now
        response_1 = instance_double("RecentTrackList", total_pages: 2)
        connection = instance_double("Connection")
        response_2 = instance_double("RecentTrackList", total_pages: 2)
        query = instance_double("Query")
        recent_tracks = instance_double("RecentTracks", to_chart: chart)
        to = Time.now
        user = "TEST_USER"
        allow(connection).to receive(:recent_tracks).with(from..to)
          .and_return(response_1)
        allow(Connection).to receive(:new).once.with(query)
          .and_return(connection)
        allow(connection).to receive(:recent_tracks).with(from..to, 2)
          .and_return(response_2)
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
