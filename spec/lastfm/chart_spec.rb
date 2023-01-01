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
        recent_tracks = instance_double("RecentTracks", to_chart: chart)
        to = Time.now
        username = "TEST_USER"
        allow(connection).to receive(:recent_tracks).with(from..to)
          .and_return(response_1)
        allow(Connection).to receive(:new).once.with("TEST_USER")
          .and_return(connection)
        allow(connection).to receive(:recent_tracks).with(from..to, 2)
          .and_return(response_2)
        allow(RecentTracks).to receive(:new).once.with(
          [
            response_1,
            response_2
          ]
        ).and_return(recent_tracks)

        expect(Chart.new(from: from, to: to, username: username).get)
          .to eq chart
      end
    end
  end
end
