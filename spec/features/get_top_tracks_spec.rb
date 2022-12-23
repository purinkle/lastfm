# frozen_string_literal: true

require "spec_helper"

RSpec.describe "Get Top Tracks" do
  context "when there are no recent tracks" do
    it "is empty" do
      VCR.use_cassette("recent_tracks/none") do
        chart = Lastfm::Chart.new(
          from: Time.at(1_479_316_791),
          to: Time.at(1_479_316_791),
          user: "TEST_USER"
        )

        expect(chart.get).to be_empty
      end
    end
  end

  context "when there is one track" do
    it "lists the entry" do
      VCR.use_cassette("recent_tracks/one") do
        chart = Lastfm::Chart.new(
          from: Time.at(1_479_316_791),
          to: Time.at(1_479_316_791),
          user: "TEST_USER"
        )
        entries = chart.get
        entry = entries.first

        expect(entries.count).to eq 1
        expect(entry.track_name).to eq "TEST_TRACK"
        expect(entry.artist_name).to eq "TEST_ARTIST"
        expect(entry.play_count).to eq 1
      end
    end
  end

  context "when the same track appears multiple times" do
    it "lists one entry with the correct play count" do
      VCR.use_cassette("recent_tracks/same") do
        chart = Lastfm::Chart.new(
          from: Time.at(1_479_316_791),
          to: Time.at(1_479_316_791),
          user: "TEST_USER"
        )
        entries = chart.get
        entry = entries.first

        expect(entries.count).to eq 1
        expect(entry.track_name).to eq "TEST_TRACK"
        expect(entry.artist_name).to eq "TEST_ARTIST"
        expect(entry.play_count).to eq 2
      end
    end
  end

  context "when there are multiple tracks" do
    it "lists the entries in play count order" do
      VCR.use_cassette("recent_tracks/multiple") do
        chart = Lastfm::Chart.new(
          from: Time.at(1_479_316_791),
          to: Time.at(1_479_316_791),
          user: "TEST_USER"
        )
        entries = chart.get

        expect(entries.count).to eq 2
        [
          ["TEST_ARTIST_1", 2, "TEST_TRACK_1"],
          ["TEST_ARTIST_2", 1, "TEST_TRACK_2"]
        ].each_with_index do |(artist_name, play_count, track_name), index|
          expect(entries[index].artist_name).to eq artist_name
          expect(entries[index].play_count).to eq play_count
          expect(entries[index].track_name).to eq track_name
        end
      end
    end
  end

  context "when there are multiple pages" do
    it "lists the entries in play count order" do
      VCR.use_cassette("recent_tracks/page_1") do
        VCR.use_cassette("recent_tracks/page_2") do
          chart = Lastfm::Chart.new(
            from: Time.at(1_479_316_791),
            to: Time.at(1_479_316_791),
            user: "TEST_USER"
          )
          entries = chart.get

          expect(entries.count).to eq 2
          [
            ["TEST_ARTIST_1", 2, "TEST_TRACK_1"],
            ["TEST_ARTIST_2", 1, "TEST_TRACK_2"]
          ].each_with_index do |(artist_name, play_count, track_name), index|
            expect(entries[index].artist_name).to eq artist_name
            expect(entries[index].play_count).to eq play_count
            expect(entries[index].track_name).to eq track_name
          end
        end
      end
    end
  end

  context "when there are duplicates of the same track" do
    it "only shows the track once" do
      VCR.use_cassette("recent_tracks/duplicate") do
        chart = Lastfm::Chart.new(
          from: Time.at(1_479_316_791),
          to: Time.at(1_479_316_791),
          user: "TEST_USER"
        )

        entries = chart.get

        entry = entries.first
        expect(entries.count).to eq 1
        expect(entry.track_name).to eq "TEST_TRACK"
        expect(entry.artist_name).to eq "TEST_ARTIST"
        expect(entry.play_count).to eq 1
      end
    end
  end

  context "when there is a track playing" do
    it "only shows played tracks" do
      VCR.use_cassette("recent_tracks/now_playing") do
        chart = Lastfm::Chart.new(
          from: Time.at(1_479_316_791),
          to: Time.at(1_479_316_791),
          user: "TEST_USER"
        )

        entries = chart.get

        entry = entries.first
        expect(entries.count).to eq 1
        expect(entry.track_name).to eq "TEST_TRACK"
        expect(entry.artist_name).to eq "TEST_ARTIST"
        expect(entry.play_count).to eq 1
      end
    end
  end
end
