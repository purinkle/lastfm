# frozen_string_literal: true

module Lastfm
  class User
    def initialize(username, http_client = HttpClient.new)
      @username = username
      @http_client = http_client
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
  end
end
