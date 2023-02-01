# frozen_string_literal: true

require "spec_helper"

module Lastfm
  RSpec.describe HttpClient do
    describe "#get" do
      it "returns the given entity" do
        response_bodies = {{foo: "bar"} => "TEST_RESPONSE"}
        connection = Lastfm::HttpClient::StubbedConnection.new(response_bodies)
        http_client = Lastfm::HttpClient.new(connection)
        stub_const("ExampleEntity", example_entity)

        response = http_client.get(ExampleEntity, foo: "bar")

        expect(response).to eq ExampleEntity.new("TEST_RESPONSE")
      end

      context "when nulled without a configuration" do
        it "returns the default response" do
          http_client = Lastfm::HttpClient.null
          stub_const("ExampleEntity", example_entity)

          response = http_client.get(ExampleEntity, foo: "bar")

          expect(response).to eq ExampleEntity.new(
            "recenttracks" => {
              "track" => [],
              "@attr" => {"totalPages" => 1}
            }
          )
        end
      end

      context "when nulled with a configuration" do
        it "returns the correct response" do
          stub_const("ExampleEntity", example_entity)
          response_bodies = {
            {foo: "bar"} => ExampleEntity.new("data" => "correct"),
            {baz: "qux"} => ExampleEntity.new("data" => "incorrect")
          }
          http_client = Lastfm::HttpClient.null(response_bodies)

          response = http_client.get(ExampleEntity, foo: "bar")

          expect(response).to eq ExampleEntity.new("data" => "correct")
        end
      end
    end

    def example_entity
      Class.new do
        attr_reader :response_body

        def initialize(response_body)
          @response_body = response_body
        end

        def ==(other)
          response_body == other.response_body
        end

        def to_h
          response_body
        end
      end
    end
  end
end
