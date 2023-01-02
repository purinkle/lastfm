# frozen_string_literal: true

module Lastfm
  class User
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

    attr_reader :adapter

    def connection
      Faraday.new(url: "http://ws.audioscrobbler.com") do |faraday|
        faraday.response :json
        faraday.adapter Faraday.default_adapter
      end
    end

    def response(page:, from:, to:)
      connection.get(
        "/2.0/",
        api_key: ENV["API_KEY"],
        format: "json",
        from: from,
        limit: 200,
        method: "user.getrecenttracks",
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
