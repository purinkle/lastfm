# frozen_string_literal: true

require "spec_helper"

module Lastfm
  RSpec.describe Query do
    describe "#username" do
      it "is the initialized username" do
        username = "TEST_USER"

        expect(Query.new(username: username).username).to eq username
      end
    end
  end
end
