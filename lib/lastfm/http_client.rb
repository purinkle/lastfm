# frozen_string_literal: true

module Lastfm
  class HttpClient
    BASE_PARAMS = {
      api_key: ENV.fetch("API_KEY"),
      method: "user.getrecenttracks",
      format: "json",
      limit: 200
    }.freeze

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
  end
end
