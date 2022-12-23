# frozen_string_literal: true

module Lastfm
  class Connection
    def initialize(page_number: 1, query:)
      @page_number = page_number
      @query = query
    end

    def get
      RecentTrackList.new(response_body)
    end

    private

    attr_reader :adapter, :page_number, :query

    def connection
      Faraday.new(url: "http://ws.audioscrobbler.com") do |faraday|
        faraday.response :json
        faraday.adapter Faraday.default_adapter
      end
    end

    def from
      query.from
    end

    def response
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

    def response_body
      response.body
    end

    def to
      query.to
    end

    def user
      query.user
    end
  end
end
