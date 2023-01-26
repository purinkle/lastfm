# frozen_string_literal: true

module Lastfm
  class HttpClient
    BASE_PARAMS = {
      api_key: ENV.fetch("API_KEY"),
      method: "user.getrecenttracks",
      format: "json",
      limit: 200
    }.freeze

    def self.null(response_bodies = {})
      new(StubbedConnection.new(response_bodies))
    end

    def initialize(connection = build_connection)
      @connection = connection
    end

    def get(entity, params)
      entity.new(response_body(params))
    end

    private

    def build_connection
      Faraday.new(url: "http://ws.audioscrobbler.com") do |faraday|
        faraday.response :json
        faraday.adapter Faraday.default_adapter
      end
    end

    def response(params)
      @connection.get("/2.0/", **BASE_PARAMS, **params)
    end

    def response_body(params)
      response(params).body
    end

    class StubbedConnection
      def initialize(response_bodies)
        @response_bodies = response_bodies
      end

      def get(url, params)
        response_body = @response_bodies.fetch(
          params.except(*BASE_PARAMS.keys),
          {}
        )

        StubbedResponse.new(response_body)
      end

      private

      StubbedResponse = Struct.new(:body)
    end
  end
end
