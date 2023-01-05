module Lastfm
  class HttpClient
    def self.null(response_body)
      new(StubbedConnection.new(response_body))
    end

    def initialize(connection = nil)
      @connection = connection || build_connection
    end

    def get(entity, query_params)
      entity.new(response_body(query_params))
    end

    private

    def build_connection
      Faraday.new(url: "http://ws.audioscrobbler.com") do |faraday|
        faraday.response :json
        faraday.adapter Faraday.default_adapter
      end
    end

    def response_body(query_params)
      response(query_params).body
    end

    def response(query_params)
      @connection.get(
        "/2.0/",
        api_key: ENV["API_KEY"],
        format: "json",
        limit: 200,
        method: "user.getrecenttracks",
        **query_params
      )
    end

    class StubbedConnection
      def initialize(response_body)
        @response = StubbedResponse.new(response_body)
      end

      def get(url, params)
        @response
      end

      class StubbedResponse
        attr_reader :body

        def initialize(body)
          @body = body
        end
      end
    end
  end
end
