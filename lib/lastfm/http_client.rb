# frozen_string_literal: true

module Lastfm
  class HttpClient
    REQUEST_PARAMS = {
      api_key: ENV.fetch("API_KEY"),
      format: "json",
      limit: 200,
      method: "user.getrecenttracks"
    }
    URL = "http://ws.audioscrobbler.com/2.0/"

    def self.null(response_body)
      new(StubbedFaraday.new(response_body))
    end

    def initialize(connection = nil)
      @connection = connection || build_connection
    end

    def get(entity, query_params)
      entity.new(response_body(query_params))
    end

    private

    def build_connection
      Faraday.new do |faraday|
        faraday.response :json
        faraday.adapter Faraday.default_adapter
      end
    end

    def response_body(query_params)
      response(query_params).body
    end

    def response(query_params)
      @connection.get(URL, **REQUEST_PARAMS, **query_params)
    end

    class StubbedFaraday
      def initialize(response_body)
        @response = StubbedResponse.new(response_body)
      end

      def get(url, params)
        @response
      end

      StubbedResponse = Struct.new(:body)
    end
  end
end
