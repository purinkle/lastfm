# frozen_string_literal: true

require "spec_helper"

module Lastfm
  RSpec.describe Query do
    describe "#user" do
      it "is the initialized user" do
        user = "TEST_USER"

        expect(Query.new(user: user).user).to eq user
      end
    end
  end
end
