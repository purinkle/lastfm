# frozen_string_literal: true

module Lastfm
  class User
    def initialize(username)
      @username = username
      @http_client = HttpClient.new
    end

    def recent_tracks(period, page_number = 1)
      @http_client.get(
        RecentTrackList,
        user: @username,
        page: page_number,
        from: period.min.to_i,
        to: period.max.to_i
      )
    end

    class HttpClient
      BASE_PARAMS = {
        api_key: ENV.fetch("API_KEY"),
        method: "user.getrecenttracks",
        format: "json",
        limit: 200
      }.freeze

      def initialize
        @connection = build_connection
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
end
