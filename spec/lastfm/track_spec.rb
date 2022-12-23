# frozen_string_literal: true

require "spec_helper"

module Lastfm
  RSpec.describe Track do
    describe ".build" do
      it "provides a simple way to build a track" do
        track = Track.build(
          artist_name: "TEST_ARTIST",
          track_name: "TEST_TRACK"
        )

        expect(track).to eq Track.new(
          "artist" => {"#text" => "TEST_ARTIST"},
          "name" => "TEST_TRACK"
        )
      end
    end

    describe "#artist_name" do
      it "is 'TEST_ARTIST'" do
        artist_name = "TEST_ARTIST"
        artist_data = {"#text" => artist_name}
        artist = instance_double("Artist", name: artist_name)
        data = {"artist" => artist_data}
        allow(Artist).to receive(:new).once.with(artist_data).and_return(artist)

        expect(Track.new(data).artist_name).to eq artist_name
      end
    end

    describe "#timestamp" do
      it "is 'TEST_TIME'" do
        data = {"date" => {"uts" => "TEST_TIME"}}
        track = Track.new(data)

        date = track.date

        expect(date).to eq "TEST_TIME"
      end
    end

    describe "#eql?" do
      context "when the tracks have the same artist and name" do
        it "is equal" do
          data = {
            "artist" => {"#text" => "TEST_ARTIST"},
            "name" => "TEST_TRACK"
          }

          expect(Track.new(data)).to eql Track.new(data)
        end
      end

      context "when the tracks have different data" do
        it "is not equal" do
          data = {
            "artist" => {"#text" => "TEST_ARTIST"},
            "name" => "TEST_TRACK"
          }
          different_track = Track.new(data.merge("name" => "OTHER_TRACK"))

          expect(Track.new(data)).to_not eql different_track
        end
      end
    end

    describe "#hash" do
      it "is the hash of the array of artist and track" do
        artist_name = "TEST_ARTIST"
        track_name = "TEST_TRACK"
        data = {
          "artist" => {"#text" => artist_name},
          "name" => track_name
        }

        expect(Track.new(data).hash).to eq [artist_name, track_name].hash
      end
    end

    describe "#name" do
      it "is the initialized track name" do
        track_name = "TEST_TRACK"
        data = {"name" => track_name}

        expect(Track.new(data).name).to eq track_name
      end
    end

    describe "#==" do
      context "when the tracks have the same artist and name" do
        it "is equal" do
          data = {
            "artist" => {"#text" => "TEST_ARTIST"},
            "name" => "TEST_TRACK"
          }

          expect(Track.new(data)).to eq Track.new(data)
        end
      end

      context "when the tracks have different data" do
        it "is not equal" do
          data = {
            "artist" => {"#text" => "TEST_ARTIST"},
            "name" => "TEST_TRACK"
          }
          different_track = Track.new(data.merge("name" => "OTHER_TRACK"))

          expect(Track.new(data)).to_not eq different_track
        end
      end
    end
  end
end
