# frozen_string_literal: true
require "spec_helper"

module Lastfm
  RSpec.describe Artist do
    describe "#name" do
      it "is 'TEST_ARTIST'" do
        name = "TEST_ARTIST"

        expect(Artist.new("#text" => name).name).to eq name
      end
    end
  end
end
