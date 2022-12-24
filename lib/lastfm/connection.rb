# frozen_string_literal: true

module Lastfm
  class Connection
    def initialize(page_number: 1, query:)
      @page_number = page_number
      @query = query
    end

    def recent_tracks(period)
      RecentTrackList.new(response_body(
        from: period.min.to_i,
        to: period.max.to_i
      ))
    end

    private

    attr_reader :adapter, :page_number, :query

    def connection
      Faraday.new(url: "http://ws.audioscrobbler.com") do |faraday|
        faraday.response :json
        faraday.adapter Faraday.default_adapter
      end
    end

    def response(from:, to:)
      connection.get(
        "/2.0/",
        api_key: ENV["API_KEY"],
        format: "json",
        from: from,
        limit: 200,
        method: "user.getrecenttracks",
        page: page_number,
        to: to,
        user: user
      )
    end

    def response_body(from:, to:)
      response(from: from, to: to).body
    end

    def user
      query.user
    end
  end
end
