# frozen_string_literal: true

require "spec_helper"

module Lastfm
  RSpec.describe RecentTracks do
    describe "#to_chart" do
      it "is the tracks converted to a chart" do
        chart = []
        tracks_data = []
        data = instance_double("Adapter", tracks: tracks_data)
        tracks = instance_double("Tracks", to_chart: chart)
        allow(Tracks).to receive(:new).once.with(tracks_data).and_return(tracks)

        expect(RecentTracks.new([data]).to_chart).to eq chart
      end
    end
  end
end
