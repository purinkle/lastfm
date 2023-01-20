# frozen_string_literal: true

module Lastfm
  class User
    BASE_PARAMS = {
      api_key: ENV.fetch("API_KEY"),
      method: "user.getrecenttracks",
      format: "json",
      limit: 200
    }.freeze

    def initialize(username)
      @username = username
    end

    def recent_tracks(period, page_number = 1)
      RecentTrackList.new(response_body(
        page: page_number,
        from: period.min.to_i,
        to: period.max.to_i
      ))
    end

    private

    def connection
      Faraday.new(url: "http://ws.audioscrobbler.com") do |faraday|
        faraday.response :json
        faraday.adapter Faraday.default_adapter
      end
    end

    def response(page:, from:, to:)
      connection.get(
        "/2.0/",
        **BASE_PARAMS,
        from: from,
        page: page,
        to: to,
        user: @username
      )
    end

    def response_body(page:, from:, to:)
      response(page: page, from: from, to: to).body
    end
  end
end
