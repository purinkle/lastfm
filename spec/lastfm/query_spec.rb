# frozen_string_literal: true

require "spec_helper"

module Lastfm
  RSpec.describe Query do
    describe "#from" do
      it "is the initialized from time as a timestamp" do
        from = Time.now
        to = Time.now
        user = "TEST_USER"

        expect(Query.new(from: from, to: to, user: user).from).to eq from.to_i
      end
    end

    describe "#to" do
      it "is the initialized to time as a timestamp" do
        from = Time.now
        to = Time.now
        user = "TEST_USER"

        expect(Query.new(from: from, to: to, user: user).to).to eq to.to_i
      end
    end

    describe "#user" do
      it "is the initialized user" do
        from = Time.now
        to = Time.now
        user = "TEST_USER"

        expect(Query.new(from: from, to: to, user: user).user).to eq user
      end
    end
  end
end
