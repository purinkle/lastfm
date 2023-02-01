# frozen_string_literal: true

module Lastfm
  class User
    def self.null(username, recent_track_lists = {})
      response_bodies = recent_track_lists.transform_keys do |key|
        {
          user: username,
          page: key.fetch(:page_number, 1),
          from: key[:period].min.to_i,
          to: key[:period].max.to_i
        }
      end

      new(username, HttpClient.null(response_bodies))
    end

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
