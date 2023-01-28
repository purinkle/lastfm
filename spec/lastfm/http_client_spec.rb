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

          expect(response).to eq ExampleEntity.new({})
        end
      end

      context "when nulled with a configuration" do
        it "returns the correct response" do
          response_bodies = {
            {foo: "bar"} => "TEST_CORRECT_RESPONSE",
            {baz: "qux"} => "TEST_INCORRECT_RESPONSE"
          }
          http_client = Lastfm::HttpClient.null(response_bodies)
          stub_const("ExampleEntity", example_entity)

          response = http_client.get(ExampleEntity, foo: "bar")

          expect(response).to eq ExampleEntity.new("TEST_CORRECT_RESPONSE")
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
      end
    end
  end
end
